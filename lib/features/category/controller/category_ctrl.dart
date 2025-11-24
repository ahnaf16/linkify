import 'package:linkify/features/category/repository/category_repo.dart';
import 'package:linkify/main.export.dart';
import 'package:linkify/models/category.dart';
import 'package:nanoid2/nanoid2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_ctrl.g.dart';

@riverpod
class CategoryCtrl extends _$CategoryCtrl {
  final _repo = locate<CategoryRepo>();
  @override
  FutureOr<List<Category>> build() async {
    final res = await _repo.getCategories();
    return res.fold((l) => throw l, (r) => r);
  }

  Future<bool> saveCategory(String name) async {
    if (name.isEmpty) {
      return Toaster.showError('Category name cannot be empty').andReturn(false);
    }

    final category = Category(id: nanoid(), name: name, createdAt: DateTime.now());
    final res = await _repo.saveCategory(category);
    res.fold((l) => Toaster.showError(l), (r) => r);

    return res.isRight();
  }

  Future<bool> updateCategory(Category editing, String name) async {
    if (name.isEmpty) {
      return Toaster.showError('Category name cannot be empty').andReturn(false);
    }
    final category = editing.copyWith(name: name);
    final res = await _repo.saveCategory(category);
    res.fold((l) => Toaster.showError(l), (r) => r);
    return res.isRight();
  }

  Future<void> deleteCategory(String id) async {
    final res = await _repo.deleteCategory(id);
    res.fold((l) => Toaster.showError(l), (r) => ref.invalidateSelf());
  }
}
