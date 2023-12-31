import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Products.dart';

class Users {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? password;
  List<Products> cartProduct=[];

  Users(
      {required this.name,
      required this.phone,
      required this.email,
      required this.password,
      required this.id,
      required this.cartProduct});

  factory Users.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Users(
        id: snapshot.id,
        name: data["name"],
        phone: data["phone"],
        email: data["email"],
        password: data["password"],
        cartProduct: data['cartProduct']);
  }

  Future<Users> fetchUser(String userId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('users').doc(userId).get();

    Map<String, dynamic> userData = snapshot.data()!;
    Users user = Users(
      id: userId,
      name: userData['name'],
      email: userData['email'],
      phone: userData['phone'],
      password: userData['password'],
      cartProduct: userData['cartProduct'],
    );

    return user;
  }

}
