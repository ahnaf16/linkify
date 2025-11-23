import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:linkify/features/link/controller/link_editing_ctrl.dart';
import 'package:linkify/main.export.dart';
import 'package:linkify/models/link_data.dart';
import 'package:screwdriver/screwdriver.dart';

class AddLinkView extends HookConsumerWidget {
  const AddLinkView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = context.query('url');
    final editing = context.tryGetExtra<LinkData>();
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final linkState = ref.watch(linkEditingCtrlProvider(editing));
    final linkCtrl = useMemoized(() => ref.read(linkEditingCtrlProvider(editing).notifier));

    final loading = useState(false);

    useEffect(() {
      if (url != null) {
        wait(() async {
          linkCtrl.updateUrl(url);
          loading.truthy();
          final upData = await linkCtrl.pasteLink();
          loading.falsey();

          if (upData != null) formKey.currentState?.patchValue(upData);
        });
      }
      return null;
    }, [url]);

    return Scaffold(
      appBar: AppBar(
        title: editing == null ? const Text('Add a Link') : const Text('Update Link'),
        actions: [
          IconButton(
            onPressed: () {
              const u = 'https://www.youtube.com/watch?v=v4H2fTgHGuc';
              formKey.currentState?.patchValue({'url': u});
            },
            icon: const Icon(Icons.code),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (loading.value) return;
          loading.truthy();
          bool ok;
          if (editing == null) {
            ok = await linkCtrl.saveLink();
          } else {
            ok = await linkCtrl.updateLink(editing.id);
          }
          loading.falsey();

          if (context.mounted && ok) context.pop();
        },
        foregroundColor: context.colors.onSurface,
        label: const Text('Save'),
        icon: const Icon(Icons.save_rounded),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: Pads.lg(),
            child: FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Insets.med,
                children: [
                  KTextField(
                    name: 'url',
                    title: 'URL',
                    hintText: 'https://example.com',
                    initialValue: url ?? editing?.url,
                    onChanged: (v) => linkCtrl.updateUrl(v),
                    outsideSuffix: Opacity(
                      opacity: linkState.url.isNullOrBlank ? .5 : 1,
                      child: GestureDetector(
                        onTap: () async {
                          if (loading.value) return;
                          final String? url = linkState.url;
                          if (url.isNullOrBlank) {
                            Toaster.showError('Please enter a valid URL');
                            return;
                          }

                          loading.truthy();
                          final upData = await linkCtrl.pasteLink();
                          loading.falsey();

                          if (upData != null) {
                            formKey.currentState?.patchValue(upData);
                          }
                        },
                        child: DecoContainer(
                          color: context.colors.primaryContainer,
                          padding: Pads.sym(Insets.med, 6),
                          borderRadius: Corners.circle,
                          child: const Icon(Icons.content_paste_go),
                        ),
                      ),
                    ),
                  ),
                  KTextField(
                    name: 'title',
                    title: 'Title',
                    hintText: 'Link Title',
                    initialValue: editing?.title,
                    onChanged: (v) => linkCtrl.updateTitle(v),
                  ),
                  KTextField(
                    name: 'desc',
                    title: 'Description',
                    hintText: 'Describe why, what?',
                    initialValue: editing?.description,
                    maxLines: 3,
                    borderRadius: Corners.medBorder,
                    onChanged: (v) => linkCtrl.updateDescription(v),
                  ),

                  KSwitchTile(
                    title: 'Pin this link?',
                    subtitle: 'Pinned links will appear at the top of the list',
                    value: linkState.isPinned,
                    onChanged: linkCtrl.updateIsPinned,
                  ),
                ],
              ),
            ),
          ),
          if (loading.value)
            // ignore: deprecated_member_use
            LinearProgressIndicator(year2023: false, backgroundColor: context.colors.primaryContainer),
        ],
      ),
    );
  }
}
