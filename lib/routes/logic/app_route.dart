import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkify/main.export.dart';

class AppRoute extends GoRoute {
  AppRoute(
    RPath path,
    Widget Function(GoRouterState s) builder, {
    List<GoRoute> routes = const [],
    super.redirect,
    Function(GoRouterState s)? onPop,
    bool canPop = true,
  }) : super(
         path: path.path,
         name: path.name,
         onExit: (c, s) {
           onPop?.call(s);
           return canPop;
         },
         routes: routes,
         pageBuilder: (context, state) {
           final pageContent = builder(state);
           final isIos = context.isIos;
           if (isIos) return CupertinoPage(name: path.name, child: pageContent);
           return MaterialPage(name: path.name, child: pageContent);
         },
       );
}

class RPath {
  const RPath(this.path);

  final String path;

  Future<T?> push<T extends Object?>(BuildContext context, {QMap query = const {}, Object? extra}) {
    query = query.map((k, v) => MapEntry(k, '$v'));
    final route = Uri(path: path, queryParameters: query).toString();
    return context.push(route, extra: extra);
  }

  void go(BuildContext context, {QMap query = const {}, Object? extra}) {
    final route = Uri(path: path, queryParameters: query).toString();
    return context.go(route, extra: extra);
  }

  String get name => nameFromPath(path);

  String get title => name.titleCase;

  RPath operator +(RPath newPath) => RPath('$path${newPath.path}');

  static String nameFromPath(String path) {
    final parts = path.split('/');
    final last = parts.last;
    if (!last.startsWith(':')) return last;
    final name = parts[parts.length - 2];
    return name;
  }
}
