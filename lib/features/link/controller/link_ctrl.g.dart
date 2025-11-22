// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LinkCtrl)
const linkCtrlProvider = LinkCtrlProvider._();

final class LinkCtrlProvider
    extends $AsyncNotifierProvider<LinkCtrl, List<LinkData>> {
  const LinkCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'linkCtrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$linkCtrlHash();

  @$internal
  @override
  LinkCtrl create() => LinkCtrl();
}

String _$linkCtrlHash() => r'99fddc80ec0b327e116cee34fd7d553a2a03e168';

abstract class _$LinkCtrl extends $AsyncNotifier<List<LinkData>> {
  FutureOr<List<LinkData>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<LinkData>>, List<LinkData>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<LinkData>>, List<LinkData>>,
              AsyncValue<List<LinkData>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
