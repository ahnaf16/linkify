import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox.square(dimension: 25, child: CircularProgressIndicator.adaptive(strokeWidth: 2)),
            const Gap(40),
            Text(kAppName, style: context.text.titleLarge),
          ],
        ),
      ),
    );
  }
}
