import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:linkify/main.export.dart';
import 'package:linkify/models/category.dart';

class CategoryRepo {
  final _coll = FirebaseFirestore.instance.collection('categories');

  FutureReport<List<Category>> getCategories() async {
    try {
      final hiveBox = await Hive.openBox<Category>(HBoxes.categoryBoxName);
      final localTags = hiveBox.values.toList();
      return right(localTags);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> saveCategory(Category category) async {
    try {
      final linkBox = Hive.box<Category>(HBoxes.categoryBoxName);
      await linkBox.put(category.id, category);
      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> deleteCategory(String id) async {
    try {
      final linkBox = Hive.box<Category>(HBoxes.categoryBoxName);
      await linkBox.delete(id);
      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }
}
