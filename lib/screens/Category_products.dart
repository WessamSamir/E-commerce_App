import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/Personal_info.dart';
import '../models/Users.dart';
import '../models/Products.dart';
import 'product_details.dart';

class category_product extends StatefulWidget {
  final String userEmail;
  final String category_name;
  const category_product(this.userEmail, this.category_name, {super.key});

  @override
  State<category_product> createState() => _category_productState();
}

class _category_productState extends State<category_product> {
  double screenWidth = 0;

  @override
  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    screenWidth = screenWidth1;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Products> productss = snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return Products(
                id: doc.id,
                product_name: data['P_name'],
                description: data['description'],
                product_price: data['P_price'],
                product_img: data['P_image'],
                category: data['category'],
                fav: data['fav']
              );
            }).where((product) =>
            product.category == widget.category_name).toList();
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.category_name,
                  style: const TextStyle(
                    fontSize: 40,
                    fontFamily: "Sweety",
                    color: Colors.black12,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: BackButton(
                  color: Colors.cyan,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsetsDirectional.all(20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ListView.separated(
                        itemBuilder: (context, index) {
                          Products pr = productss[index];
                          return product(pr);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20.0,
                        ),
                        itemCount: productss.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  Widget product(Products pr) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetails(pr, widget.userEmail)));
        });
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    width: screenWidth * 0.7,
                    height: screenWidth * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(screenWidth * 0.2),
                      image: const DecorationImage(
                          image: AssetImage(
                              "Assets/images/beautiful-night-sky-with-shiny-stars.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          // setState(() {
                          //   pr.fav = !pr.fav;
                          //   pr.fav
                          //       ? widget.user.fav.add(pr)
                          //       : widget.user.fav.remove(pr);
                          // });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: pr.fav
                              ? const Color.fromRGBO(255, 33, 131, 1.0)
                              : Colors.white70,
                          size: 30.0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // setState(() {
                          //   pr.cart = !pr.cart;
                          //   pr.cart
                          //       ? widget.user.cart.add(pr)
                          //       : widget.user.cart.remove(pr);
                          // });
                        },
                        icon: Icon(
                          Icons.shopping_cart_sharp,
                          color:
                              pr.cart ? Colors.lightBlueAccent : Colors.white70,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          CircleAvatar(
            radius: screenWidth * 0.35,
            backgroundImage: NetworkImage(pr.product_img),
          ),
          SizedBox(
            width: 140 * 2,
            height: 140 * 2,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      pr.product_name,
                      style: const TextStyle(
                        fontFamily: 'Arial',
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                    RatingBar.builder(
                      itemSize: 20.0,
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsetsDirectional.all(4.0),
                      itemBuilder: (context, _) => const Icon(
                        FontAwesomeIcons.solidHeart,
                        color: Colors.white,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${pr.product_price} \$ ',
                          style: const TextStyle(
                            fontFamily: 'fastForward',
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
