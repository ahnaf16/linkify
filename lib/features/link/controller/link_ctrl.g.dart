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

@ProviderFor(LinkDetailsCtrl)
const linkDetailsCtrlProvider = LinkDetailsCtrlFamily._();

final class LinkDetailsCtrlProvider
    extends $AsyncNotifierProvider<LinkDetailsCtrl, LinkData> {
  const LinkDetailsCtrlProvider._({
    required LinkDetailsCtrlFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'linkDetailsCtrlProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$linkDetailsCtrlHash();

  @override
  String toString() {
    return r'linkDetailsCtrlProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LinkDetailsCtrl create() => LinkDetailsCtrl();

  @override
  bool operator ==(Object other) {
    return other is LinkDetailsCtrlProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$linkDetailsCtrlHash() => r'8816ae889f22c267a80c1c067102b819d843fd36';

final class LinkDetailsCtrlFamily extends $Family
    with
        $ClassFamilyOverride<
          LinkDetailsCtrl,
          AsyncValue<LinkData>,
          LinkData,
          FutureOr<LinkData>,
          String
        > {
  const LinkDetailsCtrlFamily._()
    : super(
        retry: null,
        name: r'linkDetailsCtrlProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LinkDetailsCtrlProvider call(String id) =>
      LinkDetailsCtrlProvider._(argument: id, from: this);

  @override
  String toString() => r'linkDetailsCtrlProvider';
}

abstract class _$LinkDetailsCtrl extends $AsyncNotifier<LinkData> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<LinkData> build(String id);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<LinkData>, LinkData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LinkData>, LinkData>,
              AsyncValue<LinkData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
