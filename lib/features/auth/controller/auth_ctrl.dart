import 'package:linkify/features/auth/repository/auth_repo.dart';
import 'package:linkify/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_ctrl.g.dart';

@riverpod
class AuthCtrl extends _$AuthCtrl {
  final _repo = locate<AuthRepo>();
  @override
  Stream<bool?> build() {
    return _repo.authStateChange().map((user) => user != null);
  }

  Future<bool> login(String? email, String? password) async {
    final res = await _repo.login(email, password);
    return res.fold(
      (l) => Toaster.showError(l).andReturn(false),
      (r) => Toaster.showSuccess('Logged in successfully').andReturn(true),
    );
  }

  Future<bool> logout() async {
    final res = await _repo.logout();
    return res.fold((l) => false, (r) => true);
  }

  Future<bool> linkEmail(String email, String password) async {
    final res = await _repo.linkEmail(email, password);
    return res.fold((l) => false, (r) => true);
  }
}
