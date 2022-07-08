import '/models/models.dart';

abstract class BaseUserRepository {
  //In order to write and read the user object from the database the user repository is created.
  //First in the base repository file we define the methods.
  //The get user method takes the user id then it will return a stream that gives us information on that specific user.
  //It will be updated everytime the user object is updated into Firestore.
  Stream<User> getUser(String userId);
  //The create user method will take the user object and will create a new document in Firestore.
  Future<void> createUser(User user);
  //The update user method will update some information of the user in the Firestore document.
  Future<void> updateUser(User user);
}

//We implement these methods inside the user repository.