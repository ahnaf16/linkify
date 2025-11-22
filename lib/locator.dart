import 'package:get_it/get_it.dart';
import 'package:linkify/features/auth/repository/auth_repo.dart';

final locate = GetIt.instance;

Future<void> initDependencies() async {
  locate.registerSingletonIfAbsent<AuthRepo>(() => AuthRepo());
}
