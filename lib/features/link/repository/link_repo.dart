import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:linkify/main.export.dart';
import 'package:linkify/models/link_data.dart';

class LinkRepo {
  final _coll = FirebaseFirestore.instance.collection('links');

  FutureReport<List<LinkData>> getLinks() async {
    try {
      final hiveBox = await Hive.openBox<LinkData>(HBoxes.linkBoxName);
      final localLinks = hiveBox.values.toList();

      return right(localLinks);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> saveLink(LinkData link) async {
    try {
      final linkBox = Hive.box<LinkData>(HBoxes.linkBoxName);
      await linkBox.put(link.id, link);
      // await _saveToFB(link);
      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> updateLink(LinkData link, bool makeUnsynced) async {
    try {
      final linkBox = await Hive.openBox<LinkData>(HBoxes.linkBoxName);
      await linkBox.put(link.id, link.copyWith(isSynced: makeUnsynced ? false : link.isSynced));

      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> _markAsSync(LinkData link) async {
    try {
      if (link.isSynced) return right(unit);
      final linkBox = await Hive.openBox<LinkData>(HBoxes.linkBoxName);
      await linkBox.put(link.id, link.copyWith(isSynced: true));
      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> deleteLink(LinkData link) async {
    try {
      final linkBox = await Hive.openBox<LinkData>(HBoxes.linkBoxName);
      await linkBox.delete(link.id);
      unawaited(_deleteFromFB(link));
      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> syncAll() async {
    try {
      if (await _hasConnection() == false) return right(unit);
      final linkBox = await Hive.openBox<LinkData>(HBoxes.linkBoxName);
      final list = linkBox.values.where((e) => !e.isSynced).toList();

      cat(list.length, 'links to sync');
      if (list.isEmpty) return right(unit);

      await Future.wait(list.map((e) => _saveToFB(e)));

      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  Future<bool> _hasConnection() async => InternetConnectionChecker.instance.hasConnection;

  FVoid _saveToFB(LinkData link) async {
    try {
      if (await _hasConnection() == false) return;

      final uid = FirebaseAuth.instance.currentUser?.uid;

      final map = QMap.from(link.copyWith(isSynced: true).toMap());
      map.addAll({'userId': uid});
      await _coll.doc(link.id).set(map);
      await _markAsSync(link);
    } catch (_) {
      // ignore
    }
  }

  FVoid _deleteFromFB(LinkData link) async {
    try {
      if (await _hasConnection() == false) return;
      final exists = await _coll.doc(link.id).get().then((v) => v.exists);
      if (!exists) return;

      await _coll.doc(link.id).delete();
    } catch (_) {
      // ignore
    }
  }
}
