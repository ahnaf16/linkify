import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';

class ErrorRoutePage extends StatelessWidget {
  const ErrorRoutePage({super.key, this.error});
  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('404', style: context.text.headlineMedium),
            const SizedBox(height: 5),
            Text('Page not found', style: context.text.titleLarge),
            const SizedBox(height: 20),
            Text('$error', style: context.text.bodyLarge, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                context.go(rootPath);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
