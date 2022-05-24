import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String fullName;
  final String email;
  /*final String address;
  final String city;
  final String zipCode;*/

  const User({
    this.id,
    this.fullName = '',
    this.email = '',
   /* this.address = '',
    this.city = '',
    this.zipCode = '',*/
  });

  User copyWith({
    String? id,
    String? fullName,
    String? email,
   /* String? address,
    String? city,
    String? zipCode,*/
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      /*address: address ?? this.address,
      city: city ?? this.city,
      zipCode: zipCode ?? this.zipCode,*/
    );
  }

  factory User.fromSnapshot(DocumentSnapshot snap) {
    return User(
      id: snap.id,
      fullName: snap['fullName'],
      email: snap['email'],/*
      address: snap['address'],
      city: snap['city'],
      zipCode: snap['zipCode'],*/
    );
  }

  Map<String, Object> toDocument() {
    return {
      'fullName': fullName,
      'email': email,
     /* 'address': address,
      'city': city,
      'zipCode': zipCode*/
    };
  }

  @override
  List<Object?> get props =>
      [id, fullName, email, /*address, city, zipCode*/];
}
