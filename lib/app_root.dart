import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class AppRoot extends HookConsumerWidget {
  const AppRoot({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      final sub = ReceiveSharingIntent.instance.getMediaStream().listen(
        (v) {
          final value = v.firstOrNull;
          if (value == null) return;
          if (value.path.startsWith('http') && context.mounted) {
            RPaths.addLink.push(context, query: {'url': Uri.encodeFull(value.path)});
          }
        },
        onError: (err) {
          cat('getIntentDataStream error: $err');
        },
      );
      return sub.cancel;
    }, const []);
    return child;
  }
}
