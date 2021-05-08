import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String login, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: login, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }
}
