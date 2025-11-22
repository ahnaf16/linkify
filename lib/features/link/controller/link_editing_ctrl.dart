import 'package:any_link_preview/any_link_preview.dart';
import 'package:linkify/features/link/controller/link_ctrl.dart';
import 'package:linkify/features/link/repository/link_repo.dart';
import 'package:linkify/main.export.dart';
import 'package:linkify/models/link_data.dart';
import 'package:linkify/models/link_editing_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:screwdriver/screwdriver.dart';

part 'link_editing_ctrl.g.dart';

@riverpod
class LinkEditingCtrl extends _$LinkEditingCtrl {
  final _repo = locate<LinkRepo>();
  @override
  LinkState build(LinkData? editing) {
    if (editing != null) return LinkState.fromLinkData(editing);
    return const LinkState();
  }

  Future<SMap?> pasteLink() async {
    try {
      final url = state.url;

      if (url == null) return null;

      final isUrlValid = AnyLinkPreview.isValidLink(url, protocols: ['http', 'https']);

      if (!isUrlValid) {
        Toaster.showError('Invalid URL');
        return null;
      }

      final data = await AnyLinkPreview.getMetadata(link: url, proxyUrl: 'https://corsproxy.org/');

      if (data == null) {
        Toaster.showError('Failed to fetch metadata');
        return null;
      }

      if (data.title.isNotNullOrBlank) updateTitle(data.title);
      if (data.desc.isNotNullOrBlank) updateDescription(data.desc);
      if (data.image.isNotNullOrBlank) updateImage(data.image);
      if (data.siteName.isNotNullOrBlank) siteName(data.siteName);

      return {'title': ?data.title, 'desc': ?data.desc};
    } catch (e, s) {
      catErr('pasteLink', e, s);
    }
    return null;
  }

  void updateTitle(String? title) {
    state = state.copyWith(title: () => title);
  }

  void updateUrl(String url) {
    state = state.copyWith(url: () => url);
  }

  void updateDescription(String? description) {
    state = state.copyWith(description: () => description);
  }

  void updateImage(String? image) {
    state = state.copyWith(image: () => image);
  }

  void siteName(String? siteName) {
    state = state.copyWith(siteName: () => siteName);
  }

  void updateIsPinned(bool isPinned) {
    state = state.copyWith(isPinned: isPinned);
  }

  (bool, String) _validate() {
    if (state.url.isNullOrBlank) return (false, 'URL is required');

    return (true, '');
  }

  Future<bool> saveLink() async {
    final (isValid, message) = _validate();
    if (!isValid) return Toaster.showError(message).andReturn(false);

    final link = LinkData.fromState(state);
    final result = await _repo.saveLink(link);
    result.fold((l) => Toaster.showError('Failed to save link'), (r) {
      Toaster.showSuccess('Link saved successfully');
      ref.invalidate(linkCtrlProvider);
    });

    return result.isRight();
  }
}
