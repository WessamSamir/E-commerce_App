import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/Product_model.dart';
import '../models/Products.dart';
import '../models/Users.dart';
import '../widgets/Product_widget.dart';

class Favourite_page extends StatefulWidget {
  // final Users u;
  final DocumentSnapshot snapshot;
  final String userEmail;
  const Favourite_page(this.userEmail, this.snapshot);

  @override
  State<Favourite_page> createState() => _Favourite_pageState();
}

class _Favourite_pageState extends State<Favourite_page> {
  double screenWidth = 0;
  // late DocumentSnapshot<Map<String, dynamic>> u;

  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    screenWidth = screenWidth1;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('fav_products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Products> productss = snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              print(data);
              print('doc id');
              print(doc.id);
              return Products(
                // userEmail: data['userEmail'],
                  id: widget.snapshot.id,
                  product_name: data['product_name'],
                  description: data['product_description'],
                  product_price: data['product_price'],
                  product_img: data['product_img'],
                  category: data['category'],
                  fav: data['fav']);
            }).where((product) =>
            product.fav == true).toList();
            print('user id');
            print(widget.snapshot.id);
            return Padding(
              padding: EdgeInsetsDirectional.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ListView.separated(
                      itemBuilder: (context, index) {
                        return Product_widget(
                          productss[index],
                          widget.userEmail,
                          widget.snapshot
                        );
                      },
                      //     (context, index1) => Product_widget(
                      //     widget.user.fav[index1],
                      //     widget.user,
                      //     widget.userName),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20.0,
                      ),
                      itemCount: productss.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
