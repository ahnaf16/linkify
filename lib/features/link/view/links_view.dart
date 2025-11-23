import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:linkify/features/auth/controller/auth_ctrl.dart';
import 'package:linkify/features/auth/view/link_email_dialog.dart';
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

    final linkCtrl = useMemoized(() => ref.read(linkCtrlProvider.notifier));
    final trigger = useState(false);

    final syncing = useState(false);
    final rSync = useState(false);
    final filters = useState<Set<String>>({});

    useEffect(() {
      final connectionChecker = InternetConnectionChecker.instance;

      final sub = connectionChecker.onStatusChange.listen((status) {
        if (status == InternetConnectionStatus.connected) {
          trigger.toggle();

          wait(() async {
            if (rSync.value) return;
            rSync.value = true;
            await linkCtrl.syncToLocal();
            rSync.value = false;
          });
        }
      });

      return () {
        sub.cancel();
        connectionChecker.dispose();
      };
    }, const []);

    ref.listen(onRemoteLinkChangeProvider, (_, _) {
      if (rSync.value) return;
      wait(() async {
        rSync.value = true;
        await linkCtrl.syncToLocal();
        rSync.value = false;
      });
    });

    useEffect(() {
      if (syncing.value) return;
      wait(() async {
        syncing.value = true;
        await linkCtrl.syncToRemote();
        syncing.value = false;
      });

      return null;
    }, [trigger.value]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        actions: [
          PopOver(
            itemBuilder: (context) => [
              PullDownMenuTitle(title: Text(FirebaseAuth.instance.currentUser?.email ?? 'Guest User')),
              if (FirebaseAuth.instance.currentUser?.email == null)
                PullDownMenuItem(
                  onTap: () async {
                    await showDialog(context: context, builder: (context) => const LinkEmailDialog());
                  },
                  title: 'Link Email',
                  icon: Icons.email_rounded,
                ),
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
        onPressed: () async {
          final ok = await RPaths.addLink.push(context);
          if (ok == true) trigger.toggle();
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Link'),
      ),
      body: Stack(
        children: [
          AsyncBuilder(
            asyncValue: linksData,
            emptyIcon: const Icon(Icons.link_off_rounded, size: 35),
            emptyText: 'Your saved links will appear here',
            builder: (links) {
              links.sort((a, b) => a.isPinned == b.isPinned ? 0 : (a.isPinned ? -1 : 1));
              links = links.sortWith((e) => e.createdAt, Order.orderDate.reverse);

              return Refresher(
                onRefresh: () => linkCtrl.refresh(),
                child: Column(
                  crossAxisAlignment: .start,

                  children: [
                    if (filters.value.isNotEmpty)
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          padding: Pads.lg('lr'),
                          itemCount: filters.value.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final value = filters.value.toList()[index];
                            return RemovableChip(
                              text: value,
                              value: value,
                              onDelete: (value) {
                                filters.value = {...filters.value}..remove(value);
                                linkCtrl.search('');
                              },
                            );
                          },
                        ),
                      ),
                    Expanded(
                      child: ListView.separated(
                        padding: Pads.lg(),
                        itemCount: links.length,
                        separatorBuilder: (_, _) => const Gap(Insets.med),
                        itemBuilder: (BuildContext context, int index) {
                          final link = links[index];
                          return LinkCard(
                            link: link,
                            syncing: syncing.value,
                            afterUpdatePop: () => trigger.toggle(),
                            onSiteNameTap: (name) async {
                              await linkCtrl.search(name, onlySiteName: true);
                              filters.value = {...filters.value, name};
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // ignore: deprecated_member_use
          if (rSync.value) LinearProgressIndicator(year2023: false, backgroundColor: context.colors.primaryContainer),
        ],
      ),
    );
  }
}

class LinkCard extends HookConsumerWidget {
  const LinkCard({super.key, required this.link, required this.syncing, this.afterUpdatePop, this.onSiteNameTap});
  final LinkData link;
  final bool syncing;
  final Function()? afterUpdatePop;
  final Function(String name)? onSiteNameTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkCtrl = useMemoized(() => ref.read(linkCtrlProvider.notifier));
    return GestureDetector(
      onTap: () => RPaths.linkDetails(link.id).push(context, extra: link),
      child: DecoContainer(
        borderRadius: Corners.med,
        color: context.colors.surfaceContainer,
        padding: Pads.sm(),
        shadows: [AppTheme.shadow()],
        child: Stack(
          children: [
            Row(
              spacing: Insets.med,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PhotoViewWrapper(
                  image: link.image ?? Icons.link,
                  child: UImage(link.image ?? Icons.link, dimension: 100, borderRadius: Corners.sm),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(link.title ?? link.url, style: context.text.titleMedium!.bold, maxLines: 2),
                      if (link.description.isNotNullOrBlank)
                        Text(link.description!, maxLines: 2, style: context.text.labelMedium),
                      if (link.siteName.isNotNullOrBlank) ...[
                        const Gap(Insets.sm),
                        GestureDetector(
                          onTap: () => onSiteNameTap?.call(link.siteName!),
                          child: OptionChip(label: link.siteName!),
                        ),
                      ],
                      const Gap(Insets.sm),
                      LinksActionsWidget(
                        link: link,
                        onPinLink: () => linkCtrl.pinLink(link),
                        onDelete: () => linkCtrl.deleteLink(link),
                        afterUpdatePop: afterUpdatePop,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Positioned(
              top: 5,
              left: 5,
              child: DecoContainer(
                height: 20,
                width: 20,
                padding: Pads.xs(),
                shape: BoxShape.circle,
                color: context.colors.primaryContainer.op8,
                child: FittedBox(
                  child: syncing
                      ? const LoadingIndicator()
                      : Icon(
                          link.isSynced ? Icons.cloud_done_outlined : Icons.sync_disabled_rounded,
                          color: context.colors.primary,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinksActionsWidget extends StatelessWidget {
  const LinksActionsWidget({super.key, this.onPinLink, required this.link, this.afterUpdatePop, this.onDelete});

  final LinkData link;
  final Function()? afterUpdatePop;
  final Function()? onPinLink;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Insets.sm,
      children: [
        if (onPinLink != null)
          GestureDetector(
            onTap: () {
              Haptic.selectionClick();
              onPinLink?.call();
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
        if (onDelete != null)
          PopOver(
            itemBuilder: (context) => [
              if (link.siteName.isNotNullOrBlank) PullDownMenuTitle(title: Text(link.siteName!)),
              PullDownMenuItem(
                onTap: () async {
                  final ok = await RPaths.addLink.push(context, extra: link);

                  if (ok == true) afterUpdatePop?.call();
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
                  if (res == true) await onDelete?.call();
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
    );
  }
}
