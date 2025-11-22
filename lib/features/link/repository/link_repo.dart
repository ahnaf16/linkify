import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:linkify/main.export.dart';
import 'package:linkify/models/link_data.dart';

class LinkRepo {
  FutureReport<List<LinkData>> getLinks() async {
    try {
      final linkBox = await Hive.openBox<LinkData>(HBoxes.linkBoxName);
      return right(linkBox.values.toList());
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> saveLink(LinkData link) async {
    try {
      cat(link.toMap());
      final linkBox = Hive.box<LinkData>(HBoxes.linkBoxName);
      await linkBox.put(link.id, link);
      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> updateLink(LinkData link) async {
    try {
      final linkBox = await Hive.openBox<LinkData>(HBoxes.linkBoxName);
      await linkBox.put(link.id, link);
      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> deleteLink(LinkData link) async {
    try {
      final linkBox = await Hive.openBox<LinkData>(HBoxes.linkBoxName);
      await linkBox.delete(link.id);
      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }
}
