// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_editing_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LinkEditingCtrl)
const linkEditingCtrlProvider = LinkEditingCtrlFamily._();

final class LinkEditingCtrlProvider
    extends $NotifierProvider<LinkEditingCtrl, LinkState> {
  const LinkEditingCtrlProvider._({
    required LinkEditingCtrlFamily super.from,
    required LinkData? super.argument,
  }) : super(
         retry: null,
         name: r'linkEditingCtrlProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$linkEditingCtrlHash();

  @override
  String toString() {
    return r'linkEditingCtrlProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LinkEditingCtrl create() => LinkEditingCtrl();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LinkState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LinkState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LinkEditingCtrlProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$linkEditingCtrlHash() => r'e162c55f0d0857d303539deb15a01b97b2d1181e';

final class LinkEditingCtrlFamily extends $Family
    with
        $ClassFamilyOverride<
          LinkEditingCtrl,
          LinkState,
          LinkState,
          LinkState,
          LinkData?
        > {
  const LinkEditingCtrlFamily._()
    : super(
        retry: null,
        name: r'linkEditingCtrlProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LinkEditingCtrlProvider call(LinkData? editing) =>
      LinkEditingCtrlProvider._(argument: editing, from: this);

  @override
  String toString() => r'linkEditingCtrlProvider';
}

abstract class _$LinkEditingCtrl extends $Notifier<LinkState> {
  late final _$args = ref.$arg as LinkData?;
  LinkData? get editing => _$args;

  LinkState build(LinkData? editing);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<LinkState, LinkState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LinkState, LinkState>,
              LinkState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
