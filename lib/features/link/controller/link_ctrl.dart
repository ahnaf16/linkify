import 'dart:async';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:html/parser.dart' as html;
import 'package:http/http.dart' as http;
import 'package:linkify/features/link/repository/link_repo.dart';
import 'package:linkify/main.export.dart';
import 'package:linkify/models/link_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'link_ctrl.g.dart';

@Riverpod(keepAlive: true)
class LinkCtrl extends _$LinkCtrl {
  final _repo = locate<LinkRepo>();
  List<LinkData> _cachedLinks = [];
  @override
  Future<List<LinkData>> build() async {
    final res = await _repo.getLinks();
    return res.fold((l) => Toaster.showError(l).andReturn([]), (r) {
      _cachedLinks = r;
      return r;
    });
  }

  FVoid search(String q, {bool onlySiteName = false}) async {
    q = q.low.trim();
    if (q.isEmpty) {
      state = AsyncData(_cachedLinks);
      return;
    }
    final list = await future;

    final filtered = list
        .where(
          (e) =>
              (!onlySiteName && e.title != null && e.title!.low.contains(q)) ||
              (e.siteName != null && e.siteName!.low.contains(q)) ||
              (!onlySiteName && e.url.low.contains(q)),
        )
        .toList();
    state = AsyncData(filtered);
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

@riverpod
class LinkDetailsCtrl extends _$LinkDetailsCtrl {
  final _repo = locate<LinkRepo>();
  @override
  FutureOr<LinkData> build(String id) async {
    final res = await _repo.getLinkDetails(id);
    return res.fold((l) => throw l, (r) => r);
  }

  Future<String> _extractTextFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    final document = html.parse(response.body);

    return document.body?.text ?? '';
  }

  Future<bool> generateSummary() async {
    try {
      final link = await future;
      String url = link.url;

      if (!url.startsWith(RegExp('(http(s)://.)'))) url = 'https://$url';

      final text = await _extractTextFromUrl(url);

      final model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');

      final response = await model.generateContent([
        Content.text('Summarize this text i extracted from the link $url:\n\n$text'),
      ]);

      final newLink = link.copyWith(aiSummary: () => response.text);
      state = AsyncData(newLink);
      final isOk = await _repo.updateLink(newLink, true);
      unawaited(_repo.syncToRemote().whenComplete(() => ref.invalidate(linkCtrlProvider)));
      ref.invalidate(linkCtrlProvider);

      return isOk.isRight();
    } catch (e, s) {
      catErr('genSummary', e, s);
      return false;
    }
  }
}
