// class products{
//   final String product_name;
//   final int product_price;
//   final String product_img;
//   final String category;
//   final String description;
//   bool fav = false;
//   bool cart = false;
//   int amount=1;
//
//   products(bool fav, bool cart, {required this.product_name, required this.product_price, required this.product_img, required this.category, required this.description});
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final String id;
  final String product_name;
  final int product_price;
  final String product_img;
  final String category;
  final String description;
  late bool fav = false;
  late bool cart= false;
  int amount = 1;
  late double rating = 0;
  late String size;

  Products(
      {required this.id,
      required this.product_name,
      required this.product_price,
      required this.product_img,
      required this.category,
      required this.description,
        required this.fav,
      });


  factory Products.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Products(
      id: snapshot.id,
      product_name: data['P_name'],
      product_price: data['P_price'],
      product_img: data['P_image'],
      category: data['category'],
      description: data['description'],
      fav: data['fav']
    );
  }

  Future<List<Products>> fetchProducts() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await firestore.collection('user_orders').get();

    List<Products> products = snapshot.docs.map((doc) {
      return Products.fromFirestore(doc);
    }).toList();

    return products;
  }


}
