//import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String firstName;
  String lastName;
  String userName;
  String email;
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        userName: json['userName'],
        email: json['email']);
  }
  Map<String, dynamic> ToFirestore() {
    return {
      'id':id,
      'firstName':firstName,
      'lastName':lastName,
      'userName':userName,
      'email':email
    };
  }
}
