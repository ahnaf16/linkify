import 'package:linkify/features/tags/repository/tags_repo.dart';
import 'package:linkify/main.export.dart';
import 'package:linkify/models/tag.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tags_ctrl.g.dart';

@riverpod
class TagsCtrl extends _$TagsCtrl {
  final _repo = locate<TagsRepo>();
  @override
  FutureOr<List<Tag>> build() async {
    final res = await _repo.getTags();
    return res.fold((l) => throw l, (r) => r);
  }
}
