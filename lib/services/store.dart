import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_demo/models/Users.dart';

import '../models/products.dart';

class Store {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addUser(Users user)
  {
    _firestore.collection("users").add(
        {
          'name' : user.name,
          'phone' : user.phone,
          'email' : user.email,
          'password' : user.password
        }
    );
  }

  Future<List<products>?> loadProducts() async
  {
    List<products> p = [];
    await for(var snapshot in _firestore.collection('products').snapshots()) {
      print(snapshot.docs);
      for (var doc in snapshot.docs) {
        var data = doc.data();
        p.add(products(
          false,false,
            product_name: data['P_name'],
            product_price: data['P_price'],
            product_img: data['P_image'],
            category: data['category'],
            description: data['description']
        ));

      }
    }
    return p;
  }
}