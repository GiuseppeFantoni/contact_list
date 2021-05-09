import 'package:firebase_auth/firebase_auth.dart';
import 'package:lista_contatos/shared/utils.dart';

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
      return "";
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  Future<String> signUp({String email, String password, String name}) async {
    var msgError = '';
    if (name == '')
      return "Porfavor, verifique se os campos foram inseridos corretamente";

    setError(error) {
      msgError = verifyErrorCreatAccount(error);
    }

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((onError) => setError(onError.code))
        .then((authResult) => {});

    signOut();

    return msgError;
  }
}
