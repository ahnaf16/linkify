import 'package:flutter/material.dart';
import 'package:linkify/features/auth/controller/auth_ctrl.dart';
import 'package:linkify/main.export.dart';
import 'package:screwdriver/screwdriver.dart';

class LinkEmailDialog extends HookConsumerWidget {
  const LinkEmailDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authCtrl = useMemoized(() => ref.read(authCtrlProvider.notifier));
    final emailCtrl = useTextEditingController();
    final passwordCtrl = useTextEditingController();
    final confirmCtrl = useTextEditingController();

    return AlertDialog(
      title: const Text('Link Email'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Insets.med,
          children: [
            KTextField(hintText: 'Email', controller: emailCtrl, isDense: true),

            KTextField(hintText: 'Password', controller: passwordCtrl, isDense: true, isPassField: true),
            KTextField(hintText: 'Confirm Password', controller: confirmCtrl, isDense: true, isPassField: true),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            if (emailCtrl.text.isBlank) {
              return Toaster.showError('Please enter email').andReturn(null);
            }
            if (passwordCtrl.text.isBlank) {
              return Toaster.showError('Please enter password').andReturn(null);
            }
            if (confirmCtrl.text.isBlank) {
              return Toaster.showError('Please confirm password').andReturn(null);
            }
            if (passwordCtrl.text != confirmCtrl.text) {
              return Toaster.showError('Passwords do not match').andReturn(null);
            }
            final isOk = await authCtrl.linkEmail(emailCtrl.text.trim(), passwordCtrl.text);

            if (isOk && context.mounted) context.nPop();
          },
          child: const Text('Link'),
        ),
      ],
    );
  }
}
