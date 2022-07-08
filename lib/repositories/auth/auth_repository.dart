import 'package:firebase_auth/firebase_auth.dart' as auth;
import '/repositories/repositories.dart';
import '/models/models.dart';

//AuthRepository extends BaseAuthRepository class.
class AuthRepository extends BaseAuthRepository {
  //The firebase auth variable is declared and is essentially going to be a Firebase auth object.
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  //The firebase auth object is then added inside the constructor.
  AuthRepository(
      {auth.FirebaseAuth? firebaseAuth, required UserRepository userRepository})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _userRepository = userRepository;

  @override
  Future<auth.User?> signUp({
    required User user,
    required String password,
    //We use a try catch block for the signUp method.
  }) async {
    try {
      //
      _firebaseAuth
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          )
          .then(
            (value) => _userRepository.createUser(
              user.copyWith(id: value.user!.uid),
            ),
          );
    } catch (_) {}
  }

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
    //We use another try catch block for the login method.
  }) async {
    try {
      //We await for the signInWithEmailAndPassword method to attempt to sign in the user based on the input that we are passing.
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {}
  }

  @override
  //The user getter is using the userChanges method that will notify us if there is any changes in the user authentication.
  //It will give us an updated user object each time the user logs in or logs out.
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    //We also await for the signOut method from Firebase auth.
    await _firebaseAuth.signOut();
  }
}

//This file is connected with the base_auth_repo dart file and the user model.