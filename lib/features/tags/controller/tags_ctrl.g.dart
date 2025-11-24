// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TagsCtrl)
const tagsCtrlProvider = TagsCtrlProvider._();

final class TagsCtrlProvider
    extends $AsyncNotifierProvider<TagsCtrl, List<Tag>> {
  const TagsCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagsCtrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagsCtrlHash();

  @$internal
  @override
  TagsCtrl create() => TagsCtrl();
}

String _$tagsCtrlHash() => r'4ce1c5748f8cb05707390cef403b4f9a58d178fd';

abstract class _$TagsCtrl extends $AsyncNotifier<List<Tag>> {
  FutureOr<List<Tag>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Tag>>, List<Tag>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Tag>>, List<Tag>>,
              AsyncValue<List<Tag>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
