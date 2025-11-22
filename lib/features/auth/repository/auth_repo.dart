import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/main.export.dart';

class AuthRepo {
  Stream<User?> authStateChange() {
    try {
      return FirebaseAuth.instance.authStateChanges();
    } catch (e, s) {
      catErr('auth', e, s);
      rethrow;
    }
  }

  FutureReport<Unit> login() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }

  FutureReport<Unit> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }
}
