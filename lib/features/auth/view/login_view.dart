import 'package:flutter/material.dart';
import 'package:linkify/features/auth/controller/auth_ctrl.dart';
import 'package:linkify/main.export.dart';
import 'package:screwdriver/screwdriver.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCtrl = useMemoized(() => ref.read(authCtrlProvider.notifier));

    final emailCtrl = useTextEditingController();
    final passwordCtrl = useTextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        padding: Pads.lg(),
        child: Center(
          child: Column(
            children: [
              const Gap(Insets.offset),
              Text('Welcome to $kAppName', style: context.text.titleLarge!.bold),
              const Gap(Insets.med),
              Text(
                'Save your links in one place and access them from anywhere',
                style: context.text.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(Insets.offset),

              KTextField(hintText: 'Email', controller: emailCtrl, isDense: true),
              const Gap(Insets.med),
              KTextField(hintText: 'Password', controller: passwordCtrl, isDense: true, isPassField: true),

              const Gap(Insets.xxl),
              SubmitButton(
                height: 40,
                onPressed: (l) async {
                  if (emailCtrl.text.isBlank) {
                    return Toaster.showError('Please enter email').andReturn(null);
                  }
                  if (passwordCtrl.text.isBlank) {
                    return Toaster.showError('Please enter password').andReturn(null);
                  }

                  l.truthy();
                  await authCtrl.login(emailCtrl.text.trim(), passwordCtrl.text);
                  l.falsey();
                },
                child: const Text('Login'),
              ),

              const Gap(Insets.lg),

              SubmitButton(
                height: 40,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: context.colors.primary),
                  backgroundColor: context.colors.surface,
                  foregroundColor: context.colors.primary,
                ),
                onPressed: (l) async {
                  l.truthy();
                  await authCtrl.login(null, null);
                  l.falsey();
                },
                child: const Text('Login as Guest'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
