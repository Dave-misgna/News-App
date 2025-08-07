import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String userID;
  final String email;

  UserModel({required this.userID, required this.email});

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      userID: user.uid,
      email: user.email ?? '',
    );
  }
}
