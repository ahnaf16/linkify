import 'package:flutter/material.dart';
import 'package:linkify/features/link/controller/link_ctrl.dart';
import 'package:linkify/features/link/view/links_view.dart';
import 'package:linkify/main.export.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/blocks/all.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:screwdriver/screwdriver.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LinksDetailsView extends HookConsumerWidget {
  const LinksDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = context.param('id');
    final genLoading = useState(false);

    final linkDetailsCtrl = useMemoized(() => ref.read(linkDetailsCtrlProvider(id!).notifier));
    return Scaffold(
      appBar: AppBar(title: const Text('Link Details')),
      body: AsyncBuilder(
        asyncValue: ref.watch(linkDetailsCtrlProvider(id!)),
        builder: (link) {
          return SingleChildScrollView(
            padding: Pads.lg(),
            child: Column(
              spacing: Insets.med,
              crossAxisAlignment: .start,
              children: [
                Row(
                  crossAxisAlignment: .start,
                  spacing: Insets.med,
                  children: [
                    UImage(link.image ?? Icons.link, dimension: 110, borderRadius: Corners.sm),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: .start,
                        spacing: Insets.sm,
                        children: [
                          Text(
                            link.title ?? link.url,
                            style: context.text.titleMedium!.bold.textHeight(1.1),
                            maxLines: 2,
                          ),
                          if (link.siteName.isNotNullOrBlank) OptionChip(label: link.siteName!),
                          LinksActionsWidget(link: link),
                        ],
                      ),
                    ),
                  ],
                ),
                if (link.description.isNotNullOrBlank) Text(link.description ?? '', style: context.text.bodyMedium),
                DecoContainer(
                  color: context.colors.surfaceContainer,
                  borderRadius: Corners.med,
                  width: context.width,
                  shadows: [AppTheme.shadow()],
                  padding: Pads.med(),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        spacing: Insets.med,
                        children: [
                          Text('Summary', style: context.text.titleMedium!.bold.textHeight(1.1)),
                          if (link.aiSummary.isNotNullOrBlank)
                            AiStyledButton(
                              dense: true,
                              onPressed: () async {
                                if (genLoading.value) return;
                                genLoading.truthy();
                                await linkDetailsCtrl.generateSummary();
                                genLoading.falsey();
                              },
                            ),
                        ],
                      ),
                      Divider(color: context.colors.outlineVariant.op5, thickness: .5),
                      if (genLoading.value)
                        const Skeletonizer(child: Bone.multiText(lines: 8))
                      else if (link.aiSummary.isNullOrBlank)
                        Center(
                          child: AiStyledButton(
                            onPressed: () async {
                              genLoading.truthy();
                              await linkDetailsCtrl.generateSummary();
                              genLoading.falsey();
                            },

                            text: 'Generate Summary',
                          ),
                        )
                      else
                        MarkdownWidget(
                          data: link.aiSummary!,
                          shrinkWrap: true,
                          config: MarkdownConfig(configs: [PConfig(textStyle: context.text.bodyMedium!)]),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AiStyledButton extends StatelessWidget {
  const AiStyledButton({super.key, this.text, required this.onPressed, this.dense = false});
  final String? text;
  final VoidCallback onPressed;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final Gradient buttonGradient = LinearGradient(
      colors: [context.colors.primary, context.colors.primaryContainer],
      begin: .topLeft,
      end: .bottomRight,
    );

    return Container(
      height: dense ? 30 : 40,
      decoration: BoxDecoration(
        borderRadius: Corners.circleBorder,
        gradient: buttonGradient,
        boxShadow: [
          BoxShadow(color: context.colors.primary.op(0.5), spreadRadius: 2, blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: dense ? 10 : 30, vertical: 6),
          elevation: 0,
          shape: const RoundedRectangleBorder(borderRadius: Corners.circleBorder),
          foregroundColor: Colors.white,
        ),
        child: Row(
          mainAxisSize: .min,
          spacing: Insets.med,
          children: [
            const Icon(Icons.auto_fix_high, size: 18),
            if (text.isNotNullOrBlank)
              Text(
                text!,
                style: context.text.labelMedium!.letterSpace(.8).semiBold.textColor(context.colors.onPrimary),
              ),
          ],
        ),
      ),
    );
  }
}
