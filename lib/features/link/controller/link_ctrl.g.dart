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

String _$linkCtrlHash() => r'c261244b0d10b0db23564e835395438cae60f0ce';

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

@ProviderFor(onRemoteLinkChange)
const onRemoteLinkChangeProvider = OnRemoteLinkChangeProvider._();

final class OnRemoteLinkChangeProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LinkData>>,
          List<LinkData>,
          Stream<List<LinkData>>
        >
    with $FutureModifier<List<LinkData>>, $StreamProvider<List<LinkData>> {
  const OnRemoteLinkChangeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onRemoteLinkChangeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onRemoteLinkChangeHash();

  @$internal
  @override
  $StreamProviderElement<List<LinkData>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<LinkData>> create(Ref ref) {
    return onRemoteLinkChange(ref);
  }
}

String _$onRemoteLinkChangeHash() =>
    r'cdf9dc7ad84eae9cb66060a4e04af5f53a816bdd';
