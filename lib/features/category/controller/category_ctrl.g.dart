// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategoryCtrl)
const categoryCtrlProvider = CategoryCtrlProvider._();

final class CategoryCtrlProvider
    extends $AsyncNotifierProvider<CategoryCtrl, List<Category>> {
  const CategoryCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryCtrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryCtrlHash();

  @$internal
  @override
  CategoryCtrl create() => CategoryCtrl();
}

String _$categoryCtrlHash() => r'7d9d57d69b72710809ecdac1e395ca386c6ce52d';

abstract class _$CategoryCtrl extends $AsyncNotifier<List<Category>> {
  FutureOr<List<Category>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Category>>, List<Category>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Category>>, List<Category>>,
              AsyncValue<List<Category>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
