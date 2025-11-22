import 'package:linkify/features/link/repository/link_repo.dart';
import 'package:linkify/main.export.dart';
import 'package:linkify/models/link_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'link_ctrl.g.dart';

@Riverpod(keepAlive: true)
class LinkCtrl extends _$LinkCtrl {
  final _repo = locate<LinkRepo>();
  @override
  Future<List<LinkData>> build() async {
    final res = await _repo.getLinks();
    return res.fold((l) => Toaster.showError(l).andReturn([]), (r) => r);
  }

  Future<void> deleteLink(LinkData link) async {
    final res = await _repo.deleteLink(link);
    res.fold((l) => Toaster.showError(l), (r) {
      Toaster.showSuccess('Link deleted successfully');
      ref.invalidateSelf();
    });
  }

  Future<void> pinLink(LinkData link) async {
    final res = await _repo.updateLink(link.copyWith(isPinned: !link.isPinned));
    res.fold((l) => Toaster.showError(l), (r) => ref.invalidateSelf());
  }
}
