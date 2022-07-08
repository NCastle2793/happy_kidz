import 'package:firebase_auth/firebase_auth.dart' as auth;
import '/models/models.dart';

//We use this file to connect the app with Firebase auth (Dependency added to pubspec.yaml).

abstract class BaseAuthRepository {
  //The user getter gives us a stream of the user object coming from Firebase auth which includes all the user information.
  Stream<auth.User?> get user;
  //We use the signUp method in order to create a new account in Firebase auth.
  Future<auth.User?> signUp({
    required User user,
    required String password,
  });
  //The login method is used if the user has already created an account.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  //signOut method is used to sign out.
  Future<void> signOut();
}

//These methods are developed inside auth_repository class.