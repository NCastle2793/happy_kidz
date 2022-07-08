import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happy_kidz/models/user_model.dart';

import 'base_user_repository.dart';

//These methods come from the base user repository.

class UserRepository extends BaseUserRepository {
  //First we declare the Firebase Firestore variable.
  final FirebaseFirestore _firebaseFirestore;

  //Then we initialize it into the constructor.
  UserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore
        //We refer to the user collection.
        .collection('users')
        //We create a new document based on the user ID that we pass as an input.
        .doc(user.id)
        //We set the content of this document based on what we have inside the user object which we are converting into a document.
        .set(user.toDocument());
  }

  @override
  Stream<User> getUser(String userId) {
    print('Getting user data from Cloud Firestore');
    //With this method we are just returning a stream of user objects.
    return _firebaseFirestore
    //We take a specific document based on the user ID.
        .collection('users')
        .doc(userId)
    //Then we take a snapshot.
        .snapshots()
    //Then we map the document snapshot that we are returning from Firestore and we map it to a user object
    //using the user.fromSnapshot factory constructor.
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection('users')
    //With this method we are just going to update the document using the update method after we select the document.
        .doc(user.id)
        .update(user.toDocument())
    //A callback is registered using .then, so every time we are finished with updating the document
    //we print user document updated in the debug console so that we have feedback to see if it works.
        .then(
          (value) => print('User document updated.'),
        );
  }
}

//We now go to the authentication block. We first started in the auth repository.