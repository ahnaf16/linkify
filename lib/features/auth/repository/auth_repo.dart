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

  FutureReport<Unit> login(String? email, String? password) async {
    try {
      final auth = FirebaseAuth.instance;
      if (email != null && password != null) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        return right(unit);
      }
      await auth.signInAnonymously();
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

  FutureReport<Unit> linkEmail(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      if (user == null) return right(unit);
      await user.linkWithCredential(EmailAuthProvider.credential(email: email, password: password));
      return right(unit);
    } catch (e, s) {
      return failure(e.toString(), s: s);
    }
  }
}
