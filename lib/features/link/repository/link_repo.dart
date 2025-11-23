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

  FutureReport<Unit> syncToRemote() async {
    cat('Syncing to remote from local', 'syncToRemote');
    try {
      if (await _hasConnection() == false) return right(unit);
      final linkBox = await Hive.openBox<LinkData>(HBoxes.linkBoxName);
      final list = linkBox.values.where((e) => !e.isSynced).toList();

      if (list.isEmpty) return right(unit);

      await Future.wait(list.map((e) => _saveToFB(e)));

      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> syncToLocal() async {
    cat('Syncing to local from remote', 'syncToLocal');
    try {
      if (await _hasConnection() == false) return right(unit);
      final uid = FirebaseAuth.instance.currentUser?.uid;

      final query = await _coll.where('userId', isEqualTo: uid).get();
      final remoteList = query.docs.map((e) => LinkData.fromMap(e.data())).toList();

      final linkBox = await Hive.openBox<LinkData>(HBoxes.linkBoxName);
      final localList = linkBox.values;
      final localIds = localList.map((e) => e.id).toList();

      for (final remote in remoteList) {
        // same item exists in both
        if (localIds.contains(remote.id)) {
          final local = localList.firstWhere((e) => e.id == remote.id);

          // when remote is newer update local
          if (remote.updatedAt.isAfter(local.updatedAt)) {
            cat('Updating local', 'syncToLocal');
            await updateLink(remote, false);
          } else {
            cat('No need to update', 'syncToLocal');
          }
        } else {
          // item does not exist in local
          await linkBox.put(remote.id, remote);
        }
      }

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

  Stream<List<LinkData>> watchLinks() =>
      _coll.snapshots().map((e) => e.docs.map((e) => LinkData.fromMap(e.data())).toList());
}
