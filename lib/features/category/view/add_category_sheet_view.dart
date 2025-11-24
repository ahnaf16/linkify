import 'package:flutter/material.dart';
import 'package:linkify/features/category/controller/category_ctrl.dart';
import 'package:linkify/main.export.dart';
import 'package:linkify/models/category.dart';

class AddCategorySheetView extends HookConsumerWidget {
  const AddCategorySheetView({super.key, this.category});

  final Category? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = useMemoized(() => ref.read(categoryCtrlProvider.notifier));
    final nameCtrl = useTextEditingController(text: category?.name);
    final loading = useState(false);
    return DraggableScrollableSheet(
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
                spacing: Insets.sm,
                children: [
                  IconButton(onPressed: () => context.fmsPop(), icon: const Icon(Icons.arrow_back_rounded)),
                  Expanded(
                    child: Text(category == null ? 'Add Category' : 'Edit Category', style: context.text.titleMedium),
                  ),
                  FilledButton.icon(
                    onPressed: () async {
                      loading.truthy();
                      bool ok;
                      if (category == null) {
                        ok = await ctrl.saveCategory(nameCtrl.text.trim());
                      } else {
                        ok = await ctrl.updateCategory(category!, nameCtrl.text.trim());
                      }
                      ref.invalidate(categoryCtrlProvider);
                      loading.falsey();
                      if (context.mounted && ok) context.fmsPop();
                    },
                    icon: const Icon(Icons.save_rounded),
                    label: Text(
                      category == null
                          ? (loading.value ? 'Saving...' : 'Save')
                          : (loading.value ? 'Updating...' : 'Update'),
                    ),
                  ),
                ],
              ),
              const Gap(Insets.sm),
              KTextField(
                title: 'Category Name',
                titleStyle: context.text.titleSmall,
                hintText: 'work, movie, etc',
                isDense: true,
                controller: nameCtrl,
              ),
            ],
          ),
        );
      },
    );
  }
}
