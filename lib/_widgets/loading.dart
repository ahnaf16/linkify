import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Loader extends StatelessWidget {
  const Loader({this.widget, this.size, super.key});

  Loader.fullScreen(bool useScaffold, {super.key, Widget Function()? builder})
    : widget = _FullScreenLoader(useScaffold: useScaffold, builder: builder),
      size = null;

  Loader.grid([int count = 5, int cross = 3, Key? key])
    : widget = LoaderGrid(count, cross),
      size = null,
      super(key: key);

  Loader.list([int count = 5, Key? key]) : widget = LoaderList(count), size = null, super(key: key);

  const Loader.shimmer({super.key}) : widget = const LoaderShimmer(), size = null;

  final Widget? widget;
  final double? size;

  Widget withSF() => Scaffold(appBar: AppBar(), body: this);

  @override
  Widget build(BuildContext context) {
    if (widget != null) return widget!;
    return Center(
      child: SizedBox.square(
        dimension: size,
        child: CircularProgressIndicator(color: context.colors.primaryContainer),
      ),
    );
  }
}

class LoaderShimmer extends Loader {
  const LoaderShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton.leaf(
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: const Card(elevation: 0),
            ),
          ),

          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(BoneMock.address), Text(BoneMock.words(3))],
            ),
          ),
        ],
      ),
    );
  }
}

class LoaderBox extends Loader {
  const LoaderBox({super.key, this.height, this.width});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Skeleton.leaf(
        child: SizedBox(width: width ?? 40, height: height ?? 40, child: const Card(elevation: 0)),
      ),
    );
  }
}

class LoaderGrid extends Loader {
  const LoaderGrid(this.itemCount, this.crossCount, {this.gap, super.key});

  final int crossCount;
  final int itemCount;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: gap ?? Insets.med,
          crossAxisSpacing: gap ?? Insets.med,
          crossAxisCount: crossCount,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return const Skeleton.leaf(child: Card(elevation: 0));
        },
      ),
    );
  }
}

class LoaderList extends ConsumerWidget {
  const LoaderList(this.itemCount, {super.key, this.prov = const []});

  final int itemCount;
  final List<ProviderOrFamily> prov;

  @override
  Widget build(BuildContext context, ref) {
    final column = Column(
      spacing: 10,
      children: [...List.generate(itemCount, (i) => const LoaderShimmer()), const Gap(10)],
    );
    if (prov.isEmpty) return column;
    return Refresher(onRefresh: () async => prov.invalidAll(ref), child: column);
  }
}

class _FullScreenLoader extends Loader {
  const _FullScreenLoader({required this.useScaffold, this.builder});

  final Widget Function()? builder;
  final bool useScaffold;

  @override
  Widget build(BuildContext context) {
    Widget child = const Loader();
    if (builder != null) child = builder!();

    if (useScaffold) return Scaffold(body: child);
    return child;
  }
}

class NoDataFound extends ConsumerWidget {
  const NoDataFound({
    super.key,
    this.text,
    this.subtext,
    this.icon,
    this.isScrollable = false,
    this.prov = const [],
    this.topPadding,
    this.style,
    this.iconGap,
  });

  final Widget? icon;
  final bool isScrollable;
  final String? subtext;
  final String? text;
  final double? topPadding;
  final List<ProviderOrFamily> prov;
  final TextStyle? style;
  final double? iconGap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final child = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? const Opacity(opacity: .7, child: Icon(Icons.warning_amber_rounded, size: 40)),
          Gap(iconGap ?? Insets.lg),
          Text(text ?? 'Item not found', style: style ?? context.text.titleLarge),
          if (subtext != null) const Gap(Insets.med),
          if (subtext != null) Text(subtext!, style: context.text.titleSmall),
          const Gap(Insets.med),
        ],
      ),
    );

    if (isScrollable) {
      return Refresher(
        onRefresh: () async => prov.invalidAll(ref),
        child: CustomScrollView(
          physics: kScrollPhysics,
          slivers: [
            SliverFillRemaining(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding ?? 0),
                child: child,
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? Insets.med),
      child: child,
    );
  }
}
