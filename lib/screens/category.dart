// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_demo/screens/product_details.dart';
// import 'package:flutter_demo/screens/products_page.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// import '../models/Personal_info.dart';
// import '../models/products.dart';
//
// class category_product extends StatefulWidget {
//   final List<products> p;
//   final Person_info user;
//   final String category_name;
//   double screenWidth = 0;
//   category_product(this.p, this.user, this.category_name);
//
//   @override
//   State<category_product> createState() => _category_productState();
// }
//
// class _category_productState extends State<category_product> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth1 = MediaQuery.of(context).size.width;
//     widget.screenWidth = screenWidth1;
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('products').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           List<products> productss = snapshot.data!.docs.map((doc) {
//             Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//             return products(
//               id: doc.id,
//               product_name: data['P_name'],
//               description: data['description'],
//               product_price: data['P_price'],
//               product_img: data['P_image'],
//               category: data['category'],
//             );
//           }).toList();
//           return Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 widget.category_name,
//                 style: const TextStyle(
//                   fontSize: 40,
//                   fontFamily: "Sweety",
//                   color: Colors.black12,
//                 ),
//               ),
//               centerTitle: true,
//               backgroundColor: Colors.white,
//               elevation: 0,
//               leading: BackButton(
//                 color: Colors.cyan,
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//             body: Padding(
//               padding: EdgeInsetsDirectional.all(20.0),
//               child: Column(
//                 children: [
//                   ListView.separated(
//                     itemBuilder: (context, index) => product(widget.p[index]),
//                     separatorBuilder: (context, index) => const SizedBox(
//                       height: 20.0,
//                     ),
//                     itemCount: productss.length,
//                     physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   Widget product(products p) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ProductDetails(p, widget.user)));
//         });
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30.0),
//           color: Colors.black,
//         ),
//         height: widget.screenWidth * 0.6,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(30.0),
//           child: Stack(
//             alignment: Alignment.topCenter,
//             children: [
//               Container(
//                 height: widget.screenWidth * 0.6,
//                 child: Image.network(
//                   '${p.product_img}',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Text(
//                 '${p.category}',
//                 style: TextStyle(
//                   fontFamily: 'Sweety',
//                   color: Colors.white54,
//                   fontSize: 25.0,
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     '${p.product_name}',
//                     style: TextStyle(
//                       fontFamily: 'Arial',
//                       color: Colors.white,
//                       fontSize: 30.0,
//                     ),
//                   ),
//                   RatingBar.builder(
//                     itemSize: 20.0,
//                     initialRating: 3,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemPadding: EdgeInsetsDirectional.all(4.0),
//                     itemBuilder: (context, _) => Icon(
//                       FontAwesomeIcons.solidHeart,
//                       color: Colors.white,
//                     ),
//                     onRatingUpdate: (rating) {
//                       print(rating);
//                     },
//                   ),
//                   SizedBox(
//                     height: 5.0,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             p.cart = !p.cart;
//                             p.cart
//                                 ? widget.user.cart.add(p)
//                                 : widget.user.cart.remove(p);
//                           });
//                         },
//                         icon: Icon(
//                           Icons.shopping_cart_sharp,
//                           color:
//                               p.cart ? Colors.lightBlueAccent : Colors.white70,
//                           size: 30.0,
//                         ),
//                       ),
//                       Text(
//                         '${p.product_price} \$ ',
//                         style: TextStyle(
//                           fontFamily: 'fastForward',
//                           fontSize: 30.0,
//                           color: Colors.white,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             p.fav = !p.fav;
//                             p.fav
//                                 ? widget.user.fav.add(p)
//                                 : widget.user.fav.remove(p);
//                           });
//                         },
//                         icon: Icon(
//                           Icons.favorite,
//                           color: p.fav
//                               ? Color.fromRGBO(255, 33, 131, 1.0)
//                               : Colors.white70,
//                           size: 30.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
