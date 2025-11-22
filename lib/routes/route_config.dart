import 'dart:async';

import 'package:flutter/material.dart';
import 'package:linkify/app_root.dart';
import 'package:linkify/features/Settings/view/settings_view.dart';
import 'package:linkify/features/auth/controller/auth_ctrl.dart';
import 'package:linkify/features/auth/view/login_view.dart';
import 'package:linkify/features/link/view/add_link_view.dart';
import 'package:linkify/features/link/view/links_view.dart';
import 'package:linkify/main.export.dart';

typedef RouteRedirect = FutureOr<String?> Function(BuildContext, GoRouterState);
String rootPath = RPaths.links.path;
final routerProvider = NotifierProvider<AppRouter, GoRouter>(AppRouter.new);

class AppRouter extends Notifier<GoRouter> {
  final _rootNavigator = GlobalKey<NavigatorState>(debugLabel: 'root');

  GoRouter _appRouter(RouteRedirect? redirect) {
    return GoRouter(
      navigatorKey: _rootNavigator,
      redirect: redirect,
      initialLocation: rootPath,
      routes: [
        ShellRoute(
          routes: _routes,
          builder: (_, s, c) => AppRoot(key: s.pageKey, child: c),
        ),
      ],
      errorBuilder: (_, state) => ErrorRoutePage(error: state.error?.message),
    );
  }

  /// The app router list
  List<RouteBase> get _routes => [
    AppRoute(RPaths.splash, (_) => const SplashPage()),
    //! auth
    AppRoute(RPaths.login, (_) => const LoginView()),

    //! Home
    AppRoute(RPaths.links, (_) => const LinksView()),
    AppRoute(RPaths.addLink, (_) => const AddLinkView()),

    AppRoute(RPaths.settings, (_) => const SettingsView()),
  ];

  @override
  GoRouter build() {
    Ctx._key = _rootNavigator;
    Toaster.navigator = _rootNavigator;
    final authState = ref.watch(authCtrlProvider);

    FutureOr<String?> redirectLogic(ctx, GoRouterState state) async {
      final current = state.uri.toString();
      cat(current, 'route redirect');
      final isLoadingOrError = authState.isLoading || authState.hasError;

      if (isLoadingOrError) return RPaths.splash.path;

      final isLoggedIn = authState.value == true;

      if (!isLoggedIn) {
        cat('NOT LOGGED IN', 'route');
        if (current.contains(RPaths.login.path)) return null;
        return RPaths.login.path;
      }

      return null;
    }

    return _appRouter(redirectLogic);
  }
}

class Ctx {
  const Ctx._();
  static GlobalKey<NavigatorState>? _key;
  static BuildContext? get tryContext => _key?.currentContext;

  static BuildContext get context {
    if (_key?.currentContext == null) throw Exception('No context found');
    return _key!.currentContext!;
  }
}
