import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:linkify/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ErrorView extends HookConsumerWidget {
  const ErrorView(
    this.e,
    this.st, {
    this.prov = const [],
    this.reload,
    this.dense = false,
    super.key,
    this.loader,
    this.skipError = false,
  });

  const ErrorView.dense(
    this.e,
    this.st, {
    this.prov = const [],
    this.reload,
    super.key,
    this.loader,
    this.skipError = false,
  }) : dense = true;

  final bool dense;
  final Object e;
  final StackTrace? st;
  final List<ProviderOrFamily> prov;
  final Future Function()? reload;
  final Widget? loader;
  final bool skipError;

  Widget scrollable() => SingleChildScrollView(physics: kScrollPhysics, child: this);

  static void onFailure(Failure f, [StackTrace? st]) {
    final unAuth = f.message.low == 'unauthenticated';
    if (unAuth) return;

    Future.delayed(0.seconds, () {
      final msg = (f.isTimeOut ? 'Connection timed out' : f.safeMsg);
      final body = (f.isTimeOut ? 'Check your internet connection' : f.safeBody);

      Toaster.showError(msg, body, () => catErr('onFailure', f, st ?? f.stackTrace));
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFailure = e is Failure;

    useEffect(() {
      if (skipError) return null;
      if (e case final Failure f) onFailure(f, st);
      return null;
    }, [e, st]);

    if (isFailure) {
      if (loader != null) return loader!;
      if (dense) {
        return SafeArea(
          child: Skeletonizer(
            child: _DenseErrorView(e, st, prov: prov, reload: reload),
          ),
        );
      }
      return SafeArea(
        child: Skeletonizer(
          ignorePointers: false,
          child: DecoContainer(
            color: context.colors.surface,
            borderRadius: Corners.med,
            child: LoaderList(4, prov: prov),
          ),
        ),
      );
    }

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: dense
              ? _DenseErrorView(e, st, prov: prov, reload: reload)
              : _ErrorView(e, st, prov: prov, reload: reload),
        ),
      ),
    );
  }
}

class _DenseErrorView extends HookConsumerWidget {
  const _DenseErrorView(this.e, this.st, {this.prov = const [], this.reload});

  final Object e;
  final StackTrace? st;
  final List<ProviderOrFamily> prov;
  final Future Function()? reload;

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            prov.invalidAll(ref);
            await reload?.call();
          },
          onLongPress: () => catErr(runtimeType.toString(), e, st),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.refresh_rounded, size: 30, color: context.colors.error),
          ),
        ),
        const Gap(Insets.med),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(kError(), style: context.text.titleMedium, maxLines: 1),
              if (kDebugMode)
                Text(e.toString(), maxLines: 2)
              else
                Text('Please try again', style: context.text.bodyLarge, maxLines: 1),
            ],
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends HookConsumerWidget {
  const _ErrorView(this.e, this.st, {this.prov = const [], this.reload});

  final Object e;
  final StackTrace? st;
  final List<ProviderOrFamily> prov;
  final Future Function()? reload;

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        const Icon(Icons.warning_amber_rounded, size: 50).clickable(onTap: () => catErr(runtimeType.toString(), e, st)),
        const Gap(Insets.lg),
        Text(kError(), style: context.text.titleMedium, maxLines: 1),
        if (kDebugMode)
          Text(e.toString(), maxLines: 2, textAlign: TextAlign.center)
        else
          Text('Please try again', style: context.text.bodyLarge, maxLines: 1),
        const Gap(Insets.xl),
        SubmitButton(
          onPressed: (l) async {
            l.toggle();
            prov.invalidAll(ref);
            await reload?.call();
            l.toggle();
          },
          dense: true,
          icon: const Icon(Icons.refresh),
          child: const Text('Try again'),
        ),
      ],
    );
  }
}
