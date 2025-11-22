import 'package:get_it/get_it.dart';
import 'package:linkify/features/auth/repository/auth_repo.dart';
import 'package:linkify/features/link/repository/link_repo.dart';

final locate = GetIt.instance;

Future<void> initDependencies() async {
  locate.registerSingletonIfAbsent<AuthRepo>(() => AuthRepo());
  locate.registerSingletonIfAbsent<LinkRepo>(() => LinkRepo());
}
