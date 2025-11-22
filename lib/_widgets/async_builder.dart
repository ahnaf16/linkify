import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// A reusable widget that simplifies handling of [AsyncValue] states
/// (loading, error, data, empty) with customizable behavior.
///
/// It supports optional scaffold wrapping, empty-state detection,
/// and fallback widgets for error/loading states.
class AsyncBuilder<T> extends HookConsumerWidget {
  const AsyncBuilder({
    super.key,
    required this.asyncValue,
    required this.builder,
    this.onError,
    this.onLoading,
    this.onEmpty,
    this.scaffoldTitle,
    this.providers = const [],
    this.wrapWithScaffold = false,
    this.emptyWhen,
    this.emptyText,
    this.emptyIcon,
    this.allowEmpty = false,
  });

  /// The [AsyncValue] to build from.
  final AsyncValue<T> asyncValue;

  /// The widget to display when data is successfully loaded.
  final Widget Function(T data) builder;

  /// Custom widget to display when an error occurs.
  final Widget Function(Object error, StackTrace stack)? onError;

  /// Custom widget to display while loading.
  final Widget Function()? onLoading;

  /// Custom widget to display when data is empty.
  final Widget Function()? onEmpty;

  /// Title for scaffold when [wrapWithScaffold] is true.
  final String? scaffoldTitle;

  /// Whether to wrap loading/error/empty views in a scaffold.
  final bool wrapWithScaffold;

  /// A list of providers to be used by the [ErrorView] (optional).
  final List<ProviderOrFamily> providers;

  /// Condition to consider data as empty (in addition to empty lists or nulls).
  final bool Function(T data)? emptyWhen;

  /// Text for the default empty view.
  final String? emptyText;

  /// Icon for the default empty view.
  final Widget? emptyIcon;

  /// Whether to allow empty data through to the [builder].
  final bool allowEmpty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return asyncValue.when(
      data: (data) {
        final isEmpty = _isEmpty(data);

        if (isEmpty && !allowEmpty) {
          final emptyWidget = onEmpty?.call() ?? NoDataFound(text: emptyText, icon: emptyIcon);
          return _wrapIfNeeded(emptyWidget);
        }

        return builder(data);
      },
      loading: () {
        final widget = onLoading?.call() ?? const Loader();
        return _wrapIfNeeded(widget);
      },
      error: (error, stack) {
        final widget = onError?.call(error, stack) ?? ErrorView(error, stack, prov: providers);
        return _wrapIfNeeded(widget);
      },
    );
  }

  bool _isEmpty(T data) {
    if (data == null) return true;
    if (data is List && data.isEmpty) return true;
    if (emptyWhen != null && emptyWhen!(data)) return true;
    return false;
  }

  Widget _wrapIfNeeded(Widget child) {
    if (!wrapWithScaffold) return child;
    return Scaffold(
      appBar: scaffoldTitle != null ? AppBar(title: Text(scaffoldTitle!)) : null,
      body: Center(child: child),
    );
  }
}
