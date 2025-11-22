import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        actions: [
          CircleAvatar(backgroundColor: context.colors.primary, child: const Icon(Icons.person_rounded)),
          const Gap(Insets.sm),
        ],
      ),
      body: const SingleChildScrollView(child: Column()),
    );
  }
}
