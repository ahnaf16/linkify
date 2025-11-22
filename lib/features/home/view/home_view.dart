import 'package:flutter/material.dart';
import 'package:linkify/features/auth/controller/auth_ctrl.dart';
import 'package:linkify/main.export.dart';
import 'package:pull_down_button/pull_down_button.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCtrl = useMemoized(() => ref.read(authCtrlProvider.notifier));

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
            buttonBuilder: (context, showMenu) => CircleAvatar(
              backgroundColor: context.colors.primary,
              child: const Icon(Icons.person_rounded),
            ).clickable(onTap: showMenu),
          ),
          const Gap(Insets.sm),
        ],
      ),
      body: const SingleChildScrollView(child: Column()),
    );
  }
}
