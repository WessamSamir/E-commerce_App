import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/Cart_model.dart';
import '../models/Personal_info.dart';
import '../models/Products.dart';

class Cart_page extends StatefulWidget {
  // final Person_info user;
  // final List<Products> products;
  final String userEmail;
  const Cart_page(this.userEmail);

  @override
  State<Cart_page> createState() => _Cart_pageState();
}

class _Cart_pageState extends State<Cart_page> {
  double screenWidth = 0;
  // List<CartProducts> cartProducts = [];
  // Widget b(context, index) {
  //   List<CartProducts> cartProducts = productss
  //       .where((product) =>
  //   product.userEmail == widget.userEmail)
  //       .toList();
  //   CartProducts cartP = cartProducts[index];
  //   return Cart_product(cartP, index);
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    screenWidth = screenWidth1;
    var cartProducts;
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('user_orders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<CartProducts> productss = snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return CartProducts(
                userEmail: data['user_email'],
                product_name: data['product_name'],
                product_price: data['product_price'],
                product_img: data['product_img'],
                  quantity: data['quantity'],
              );
            }).where((product) => product.userEmail == widget.userEmail).toList();
            return Padding(
              padding: EdgeInsetsDirectional.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ListView.separated(
                      itemBuilder: (context, index) {
                        CartProducts cartP = productss[index];
                        return Cart_product(cartP, index);
                        // Cart_product(widget.products[index1], index1)
                      },
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

  Widget Cart_product(CartProducts p, index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            color: index % 2 == 0
                ? Colors.black12
                : Color.fromRGBO(1, 126, 120, 1.0),
          ),
          height: screenWidth * 0.4,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: screenWidth * 0.4,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.05),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.05),
                            child: Image.network(
                              p.product_img,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.13,
                          height: screenWidth * 0.13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(screenWidth * 0.05),
                              bottomRight: Radius.circular(screenWidth * 0.05),
                            ),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              '${p.product_price} \$ ',
                              style: TextStyle(
                                fontFamily: 'fastForward',
                                fontSize: screenWidth * 0.02,
                                color: Color.fromRGBO(225, 162, 1, 1.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${p.product_name}',
                            style: TextStyle(
                              fontFamily: 'Amperzand',
                              fontSize: screenWidth * 0.07,
                              fontWeight: FontWeight.w200,
                              color:
                                  index % 2 == 0 ? Colors.black : Colors.white,
                            ),
                          ),
                          Text(
                            '${p.quantity}',
                            style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Sweety',
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: screenWidth * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    p.quantity++;
                                  });
                                },
                                child: Container(
                                  width: screenWidth * 0.1,
                                  height: screenWidth * 0.1,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.015,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    p.quantity > 1 ? p.quantity-- : p.quantity;
                                  });
                                },
                                child: Container(
                                  width: screenWidth * 0.1,
                                  height: screenWidth * 0.1,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth * 0.13,
                height: screenWidth * 0.13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(screenWidth * 0.05),
                    bottomLeft: Radius.circular(screenWidth * 0.05),
                  ),
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {

                      // setState(() {
                      //   p.cart=!p.cart;
                      //   if(!p.cart)
                      //     widget.user.cart.remove(p);
                      // });
                    },
                    icon: Icon(
                      Icons.shopping_cart_sharp,
                      color: p.cart ? Colors.lightBlueAccent : Colors.white70,
                      size: screenWidth * 0.06,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
