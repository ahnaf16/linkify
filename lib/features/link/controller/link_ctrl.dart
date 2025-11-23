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

  FVoid refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await build());
  }

  FVoid syncToRemote() async {
    final res = await _repo.syncToRemote();
    res.fold((l) => Toaster.showError(l), (r) => ref.invalidateSelf());
  }

  FVoid syncToLocal() async {
    final res = await _repo.syncToLocal();
    res.fold((l) => Toaster.showError(l), (r) => ref.invalidateSelf());
  }

  Future<void> deleteLink(LinkData link) async {
    final res = await _repo.deleteLink(link);
    res.fold((l) => Toaster.showError(l), (r) {
      Toaster.showSuccess('Link deleted successfully');
      ref.invalidateSelf();
    });
  }

  Future<void> pinLink(LinkData link) async {
    final res = await _repo.updateLink(link.copyWith(isPinned: !link.isPinned), false);
    res.fold((l) => Toaster.showError(l), (r) => ref.invalidateSelf());
  }
}

@riverpod
Stream<List<LinkData>> onRemoteLinkChange(Ref ref) {
  final repo = locate<LinkRepo>();
  return repo.watchLinks();
}
