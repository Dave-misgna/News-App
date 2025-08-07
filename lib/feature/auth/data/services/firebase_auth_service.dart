import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/feature/auth/data/model/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;
  FirebaseAuthService(this._auth);

  Future<UserModel> registerUser(
    String userName,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;
      if (user != null) {
        return UserModel.fromFirebaseUser(user);
      } else {
        throw Exception("User not found");
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Firebase registration error'); 
    }
  }

  Future<UserModel> siginInUser(
    final String email,
    final String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      if (user != null) {
        return UserModel.fromFirebaseUser(user);
      } else {
        throw Exception("User not found");
      }
    } on FirebaseAuthException catch (e) {
       throw Exception(e.message ?? 'Firebase sign-in error');
    }
  }
}
