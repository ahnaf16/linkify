import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:linkify/main.export.dart';
import 'package:linkify/models/tag.dart';

class TagsRepo {
  final _coll = FirebaseFirestore.instance.collection('tags');

  FutureReport<List<Tag>> getTags() async {
    try {
      final hiveBox = await Hive.openBox<Tag>(HBoxes.tagBoxName);
      final localTags = hiveBox.values.toList();
      return right(localTags);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> saveLink(Tag tag) async {
    try {
      final linkBox = Hive.box<Tag>(HBoxes.tagBoxName);
      await linkBox.put(tag.id, tag);
      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }
}
