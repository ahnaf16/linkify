// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthCtrl)
const authCtrlProvider = AuthCtrlProvider._();

final class AuthCtrlProvider extends $StreamNotifierProvider<AuthCtrl, bool?> {
  const AuthCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authCtrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authCtrlHash();

  @$internal
  @override
  AuthCtrl create() => AuthCtrl();
}

String _$authCtrlHash() => r'28f1fe8d0149938a60a43cde85df4c0ca1fe3b9b';

abstract class _$AuthCtrl extends $StreamNotifier<bool?> {
  Stream<bool?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool?>, bool?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool?>, bool?>,
              AsyncValue<bool?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
