import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:linkify/_core/storage/hive_registrar.g.dart';
import 'package:linkify/firebase_options.dart';
import 'package:linkify/main.export.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapters();
  // await Hive.openBox(HBoxes.linkBoxName);

  await initDependencies();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: kAppName,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        routerConfig: ref.watch(routerProvider),
      ),
    );
  }
}
