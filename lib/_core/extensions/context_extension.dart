import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension RouteEx on BuildContext {
  GoRouter get route => GoRouter.of(this);
  GoRouterState get routeState => GoRouterState.of(this);

  T? tryGetExtra<T>() {
    if (routeState.extra case final T t) return t;
    return null;
  }

  Map<String, String> get pathParams => routeState.pathParameters;
  String? param(String key) => pathParams[key];
  Map<String, String> get queryParams => routeState.uri.queryParameters;

  String? query(String key) => queryParams[key];

  void nPop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);

  Future<T?> nPush<T extends Object?>(Widget page, {bool? fullScreen}) {
    final route = isIos
        ? CupertinoPageRoute<T>(builder: (c) => page, fullscreenDialog: fullScreen ?? false)
        : MaterialPageRoute<T>(builder: (c) => page, fullscreenDialog: fullScreen ?? false);

    return Navigator.of(this).push<T>(route);
  }

  Future<T?> nPushReplace<T extends Object?>(Widget page) {
    final route = MaterialPageRoute<T>(builder: (c) => page);
    return Navigator.of(this).pushReplacement(route);
  }
}

extension ContextEx on BuildContext {
  bool get isIos => theme.platform == TargetPlatform.iOS;
  bool get isAndroid => theme.platform == TargetPlatform.android;

  MediaQueryData get mq => MediaQuery.of(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  Size get size => MediaQuery.sizeOf(this);
  double get height => size.height;
  double get width => size.width;

  ThemeData get theme => Theme.of(this);
  CupertinoThemeData get themeCup => CupertinoTheme.of(this);

  TextTheme get text => TextTheme.of(this);
  ColorScheme get colors => ColorScheme.of(this);

  Brightness get bright => theme.brightness;

  bool get isDark => bright == Brightness.dark;
  bool get isLight => bright == Brightness.light;
}
