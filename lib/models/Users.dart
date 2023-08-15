import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? name;
  final String? phone;
  final String? email;
  final String? password;

  Users(
      {required this.name,
      required this.phone,
      required this.email,
      required this.password});

  factory Users.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Users(
        name: data["name"],
        phone: data["phone"],
        email: data["email"],
        password: data["password"]);
  }
}