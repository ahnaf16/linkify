import 'package:family_bottom_sheet/family_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:linkify/features/category/controller/category_ctrl.dart';
import 'package:linkify/features/category/view/add_category_sheet_view.dart';
import 'package:linkify/main.export.dart';

class CategorySheetView extends HookConsumerWidget {
  const CategorySheetView({super.key});

  static void show(BuildContext context) {
    FamilyModalSheet.showMaterialDefault(
      context: context,
      contentBackgroundColor: context.colors.surface,
      isScrollControlled: true,
      builder: (c) => const CategorySheetView(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryData = ref.watch(categoryCtrlProvider);
    final ctrl = useMemoized(() => ref.read(categoryCtrlProvider.notifier));

    return DraggableScrollableSheet(
      initialChildSize: .7,
      minChildSize: .4,
      maxChildSize: .95,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: Pads.lg(),
          child: Column(
            children: [
              const DragHandle(),
              Row(
                spacing: Insets.med,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text('Categories', style: context.text.titleMedium),
                  FilledButton.icon(
                    onPressed: () => context.fmsPush(const AddCategorySheetView()),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add'),
                  ),
                ],
              ),
              const Gap(Insets.sm),
              AsyncBuilder(
                asyncValue: categoryData,
                emptyText: 'No categories found',
                builder: (categories) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: categories.length,
                    separatorBuilder: (_, _) => const Gap(Insets.med),
                    itemBuilder: (BuildContext context, int index) {
                      final c = categories[index];
                      return DecoContainer(
                        padding: Pads.med(),
                        borderRadius: Corners.med,
                        color: context.colors.surfaceContainer,
                        shadows: [AppTheme.shadow()],
                        child: Row(
                          spacing: Insets.sm,
                          children: [
                            Expanded(child: Text(c.name, style: context.text.titleMedium)),
                            GestureDetector(
                              onTap: () => context.fmsPush(AddCategorySheetView(category: c)),
                              child: DecoContainer(
                                shape: BoxShape.circle,
                                borderColor: context.colors.outline,
                                borderWidth: 1,
                                padding: Pads.xs(),
                                height: 25,
                                width: 25,
                                child: FittedBox(
                                  child: Icon(Icons.edit_rounded, color: context.colors.outlineVariant.op9),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => ctrl.deleteCategory(c.id),
                              child: DecoContainer(
                                shape: BoxShape.circle,
                                borderColor: context.colors.outline,
                                borderWidth: 1,
                                padding: Pads.xs(),
                                height: 25,
                                width: 25,
                                child: FittedBox(
                                  child: Icon(Icons.delete_rounded, color: context.colors.outlineVariant.op9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
