import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

//The user model defines what the user object will look like.
//It includes all the information we need to know about the user when the user is creating an account.
class User extends Equatable {
  //The id is nullable because it is created indirectly using Firebase.
  final String? id;
  final String fullName;
  final String email;
  final String address;
  final String city;
  final String country;
  final String zipCode;

  //Inside the constructor, every time we create a user object we set every variable to an empty string.
  const User({
    this.id,
    this.fullName = '',
    this.email = '',
    this.address = '',
    this.city = '',
    this.country = '',
    this.zipCode = '',
  });

  //We use the copy with method to take the existing user object and then create a new one in which
  //we'll edit one or more variable at a time b passing a new value.
  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? address,
    String? city,
    String? country,
    String? zipCode,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  //We use this to read the user object from Firestore.
  //We are going to save a document with all the information on a specific user.
  //We'll be able to retrieve this document and convert it into a user object using the factory constructor.
  factory User.fromSnapshot(DocumentSnapshot snap) {
    return User(
      id: snap.id,
      fullName: snap['fullName'],
      email: snap['email'],
      address: snap['address'],
      city: snap['city'],
      country: snap['country'],
      zipCode: snap['zipCode'],
    );
  }

  //We have the toDocument method that will do the opposite.
  //We are going to create a user object in our app and every time we have to save it to the database, we need to first
  //convert it into a map.
  Map<String, Object> toDocument() {
    return {
      'fullName': fullName,
      'email': email,
      'address': address,
      'city': city,
      'country': country,
      'zipCode': zipCode
    };
  }

  //Finally we have the props of the user model and we use the get method from Equatable
  //in order to better differentiate between different instances of the user.
  @override
  List<Object?> get props =>
      [id, fullName, email, address, city, country, zipCode];
}

//This file works together with the auth repository and user repository.