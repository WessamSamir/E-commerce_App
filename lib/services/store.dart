import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_demo/models/Users.dart';

import '../models/Products.dart';
import 'auth.dart';

class Store {

  final String? uid;
  Store({this.uid});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final Auth userAuth;

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("users");

  final CollectionReference productCollection =
  FirebaseFirestore.instance.collection("products");

  void addToCart(Products product, DocumentSnapshot snapshot) {

    FirebaseFirestore.instance.collection('user_orders').add({
      'userId': snapshot.id,
      'product_name': product.product_name,
      'product_price' : product.product_price,
      'product_img': product.product_img,
      'quantity' : product.amount,
    }).catchError((error) {
      // Handle sign-up error
      print('Error: $error');
    });
  }

  // Future<void> addProductsForUser(DocumentSnapshot snapshot, List<Products> products) async {
  //   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   try {
  //     // Iterate over each product in the list
  //     for (final product in products) {
  //       // Add the product to Firestore under the user's collection
  //       await firestore.collection('users').doc(snapshot.id).collection('products').add(product);
  //     }
  //     print('Products added successfully for user ${snapshot.id}!');
  //   } catch (e) {
  //     print('Error adding products: $e');
  //   }
  // }

  void addToFavourite(Products product, DocumentSnapshot snapshot) {

    FirebaseFirestore.instance.collection('fav_products').add({
      'userId':snapshot.id,
      'product_name': product.product_name,
      'product_price' : product.product_price,
      'product_img': product.product_img,
      'product_description': product.description,
      'category':product.category,
      'fav':product.fav,
    }).catchError((error) {
      // Handle sign-up error
      print('Error: $error');
    });
  }

  deleteProduct(DocumentSnapshot snapshot, String prodName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection('user_orders')
        .where('userId', isEqualTo: snapshot.id)
        .where('product_name', isEqualTo: prodName)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot documentSnapshot = querySnapshot.docs.single;
        DocumentReference documentRef = documentSnapshot.reference;
        documentRef.delete();
      } else {
        print('user not found');
      }
    });
  }

  Future<bool> checkProductExists(Products prod, DocumentSnapshot snapshot) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user_orders')
        .where('product_name', isEqualTo: prod.product_name)
        .where('userId', isEqualTo: snapshot.id)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> checkProductFav(Products prod, DocumentSnapshot snapshot) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('fav_products')
        .where('product_name', isEqualTo: prod.product_name)
        .where('userId', isEqualTo: snapshot.id)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  UnFavProduct(DocumentSnapshot snapshot, String prodName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection('fav_products')
        .where('userId', isEqualTo: snapshot.id)
        .where('product_name', isEqualTo: prodName)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot documentSnapshot = querySnapshot.docs.single;
        DocumentReference documentRef = documentSnapshot.reference;
        documentRef.delete();
      } else {
        print('user not found');
      }
    });
  }



  addUser(Users user) {
    _firestore.collection("users").add(
        {
          'name' : user.name,
          'phone' : user.phone,
          'email' : user.email,
          'password' : user.password
        }
    );
  }


  Future<Users> getUser(String email) async
  {
    final snapshot = await _firestore.collection("users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => Users.fromSnapshot(e)).single;
    return userData;
  }



  // Future<List<Users>> getAllUsers() async
  // {
  //   final snapshot = await _firestore.collection("users").get();
  //   final userData = snapshot.docs.map((e) => Users.fromSnapshot(e)).toList();
  //   return userData;
  // }


  // Future<List<products>?> loadProducts() async
  // {
  //   List<products> p = [];
  //   await for(var snapshot in _firestore.collection('products').snapshots()) {
  //     print(snapshot.docs);
  //     for (var doc in snapshot.docs) {
  //       var data = doc.data();
  //       p.add(products(
  //         false,false,
  //           product_name: data['P_name'],
  //           product_price: data['P_price'],
  //           product_img: data['P_image'],
  //           category: data['category'],
  //           description: data['description']
  //       ));
  //
  //     }
  //   }
  //   return p;
  // }
}




