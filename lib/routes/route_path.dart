import 'package:linkify/routes/logic/app_route.dart';

export 'package:go_router/go_router.dart';

class RPaths {
  const RPaths._();

  // auth
  static const login = RPath('/login');
  static final signUp = login + const RPath('/sign-up');

  // home
  static const home = RPath('/home');

  // settings
  static const settings = RPath('/settings');
}
