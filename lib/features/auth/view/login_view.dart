import 'package:flutter/material.dart';
import 'package:linkify/features/auth/controller/auth_ctrl.dart';
import 'package:linkify/main.export.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCtrl = useMemoized(() => ref.read(authCtrlProvider.notifier));
    return Scaffold(
      body: Padding(
        padding: Pads.lg(),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              const Gap(Insets.med),
              Text('Welcome to $kAppName', style: context.text.titleLarge!.bold),
              const Gap(Insets.med),
              Text(
                'Save your links in one place and access them from anywhere',
                style: context.text.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(Insets.offset),

              SubmitButton(
                onPressed: (l) async {
                  l.truthy();
                  await authCtrl.login();
                  l.falsey();
                },
                child: const Text('Login as Guest'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
