import 'package:flutter/material.dart';
import 'package:linkify/features/auth/controller/auth_ctrl.dart';
import 'package:linkify/features/link/controller/link_ctrl.dart';
import 'package:linkify/main.export.dart';
import 'package:linkify/models/link_data.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:screwdriver/screwdriver.dart';

class LinksView extends HookConsumerWidget {
  const LinksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCtrl = useMemoized(() => ref.read(authCtrlProvider.notifier));
    final linksData = ref.watch(linkCtrlProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        actions: [
          PopOver(
            itemBuilder: (context) => [
              const PullDownMenuTitle(title: Text('Guest User')),
              PullDownMenuItem(onTap: () {}, title: 'Dark Theme', icon: Icons.nightlight_round),
              PullDownMenuItem(onTap: () {}, title: 'Settings', icon: Icons.settings_rounded),
              PullDownMenuItem(
                onTap: () => authCtrl.logout(),
                title: 'Logout',
                icon: Icons.logout_rounded,
                isDestructive: true,
              ),
            ],
            buttonBuilder: (context, showMenu) =>
                const CircleAvatar(child: Icon(Icons.person_rounded)).clickable(onTap: showMenu),
          ),
          const Gap(Insets.sm),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: context.colors.onSurface,
        onPressed: () => RPaths.addLink.push(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Link'),
      ),
      body: AsyncBuilder(
        asyncValue: linksData,
        emptyIcon: const Icon(Icons.link_off_rounded, size: 35),
        emptyText: 'Your saved links will appear here',
        builder: (links) {
          return ListView.separated(
            padding: Pads.lg(),
            itemCount: links.length,
            separatorBuilder: (_, _) => const Gap(Insets.med),
            itemBuilder: (BuildContext context, int index) {
              final link = links[index];
              return LinkCard(link: link);
            },
          );
        },
      ),
    );
  }
}

class LinkCard extends HookConsumerWidget {
  const LinkCard({super.key, required this.link});
  final LinkData link;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkCtrl = useMemoized(() => ref.read(linkCtrlProvider.notifier));
    return DecoContainer(
      borderRadius: Corners.med,
      color: context.colors.surfaceContainer,
      padding: Pads.sm(),
      shadows: [AppTheme.shadow()],
      child: Row(
        spacing: Insets.med,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UImage(link.image, dimension: 100, borderRadius: Corners.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(link.title ?? link.url, style: context.text.titleMedium!.bold, maxLines: 2),
                if (link.description.isNotNullOrBlank)
                  Text(link.description!, maxLines: 2, style: context.text.labelMedium),
                if (link.siteName.isNotNullOrBlank) ...[const Gap(Insets.sm), OptionChip(label: link.siteName!)],
                const Gap(Insets.sm),
                Row(
                  spacing: Insets.sm,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Haptic.selectionClick();
                        linkCtrl.pinLink(link);
                      },
                      child: DecoContainer.animated(
                        color: link.isPinned ? context.colors.primaryContainer : context.colors.surfaceContainer,
                        borderColor: link.isPinned ? context.colors.primaryContainer : context.colors.outline,
                        borderWidth: 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        shape: BoxShape.circle,
                        padding: Pads.all(6),
                        child: Icon(link.isPinned ? Icons.bookmark_rounded : Icons.bookmark_add_outlined, size: 20),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Haptic.selectionClick();
                        URLHelper.url(link.url);
                      },
                      child: DecoContainer(
                        borderColor: context.colors.outline,
                        borderWidth: 1,
                        shape: BoxShape.circle,
                        padding: Pads.all(6),
                        child: const Icon(Icons.open_in_browser_rounded, size: 20),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Copier.copy(link.url),
                      child: DecoContainer(
                        borderColor: context.colors.outline,
                        borderWidth: 1,
                        shape: BoxShape.circle,
                        padding: Pads.all(6),
                        child: const Icon(Icons.copy_rounded, size: 20),
                      ),
                    ),
                    const Spacer(),
                    PopOver(
                      itemBuilder: (context) => [
                        if (link.siteName.isNotNullOrBlank) PullDownMenuTitle(title: Text(link.siteName!)),
                        PullDownMenuItem(
                          onTap: () {
                            RPaths.addLink.push(context, extra: link);
                          },
                          title: 'Edit',
                          icon: Icons.edit_rounded,
                        ),
                        PullDownMenuItem(
                          onTap: () async {
                            final res = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Delete Link'),
                                content: const Text('Are you sure you want to delete this link?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                                  TextButton(
                                    style: TextButton.styleFrom(foregroundColor: context.colors.error),
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                            if (res == true) await linkCtrl.deleteLink(link);
                          },
                          title: 'Delete',
                          icon: Icons.delete_rounded,
                          isDestructive: true,
                        ),
                      ],
                      buttonBuilder: (context, showMenu) => GestureDetector(
                        onTap: showMenu,
                        child: DecoContainer(
                          shape: BoxShape.circle,
                          padding: Pads.all(6),
                          child: const Icon(Icons.more_horiz, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
