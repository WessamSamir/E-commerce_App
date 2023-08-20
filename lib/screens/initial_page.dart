import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../models/Personal_info.dart';
import '../models/Users.dart';
import '../models/Products.dart';
import 'Home_page.dart';
import 'cart.dart';
import 'category_page.dart';
import 'favourite_page.dart';
import 'navigation_bar.dart';

class InitialPage extends StatefulWidget {
  final DocumentSnapshot snapshot;
  // final Users us;
  const InitialPage({super.key, required this.snapshot});

  @override
  State<InitialPage> createState() => _InitialPage();
}

class _InitialPage extends State<InitialPage> {


  List<Products> Top_saling=[Products(product_name: 'Cookies',product_price: 50, product_img: 'https://th.bing.com/th/id/OIP.6e8n0Naqmwjg-IbT1UjkewHaE6?pid=ImgDet&rs=1',category: 'Food',
      description: "A cookie is a small sweet, crispy or cake-like pastry most often made with flour, sugar, liquid and fat. They are characterized by:", id: '', fav: false)];
  List<Products> for_you=[];
  double screenWidth=0;
  String app_name='hello';
  bool notification= true;
  Color online=Colors.green;
  String Image_url= "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  int current_index=0;
  List<Products> home_products=[
    Products(product_name: 'Cookies',product_price: 50,product_img: 'https://th.bing.com/th/id/OIP.6e8n0Naqmwjg-IbT1UjkewHaE6?pid=ImgDet&rs=1',category: 'Food',
        description: "A cookie is a small sweet, crispy or cake-like pastry most often made with flour, sugar, liquid and fat. They are characterized by:", id: '', fav: false),
    Products(product_name: 'Cookies',product_price: 50, product_img: 'https://th.bing.com/th/id/OIP.6e8n0Naqmwjg-IbT1UjkewHaE6?pid=ImgDet&rs=1',category: 'Food' ,
        description: "Cookies are baked treats. A cookie is a small sweet, crispy or cake-like pastry most often made with flour, sugar, liquid and fat. They are characterized by:", id: '', fav: false),
  ];

  // Person_info person=Person_info("Loay Mohamed", "01121510042", "looay432@gmail.com","2001369105694");
  List<List<Products>> Categories=[[Products(product_name: 'Cookies',product_price: 50, product_img: 'https://th.bing.com/th/id/OIP.6e8n0Naqmwjg-IbT1UjkewHaE6?pid=ImgDet&rs=1', category:'Food',
  description:"A cookie is a small sweet, crispy or cake-like pastry most often made with flour, sugar, liquid and fat. They are characterized by:", id: '', fav: false),]];
  List<String> listOfStrings = [
    'Home',
    'favourite',
    'Explore',
    'Cart',
    'Account',
  ];

  void onTabTapped(int index) {
    setState(() {
      current_index = index;
    });}

  // Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
  //
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   Future<DocumentSnapshot<Map<String, dynamic>>> snapshot = (await firestore
  //       .collection('users')
  //       .doc(widget.snapshot.id)
  //       .get()) as Future<DocumentSnapshot<Map<String, dynamic>>>;
  //   return snapshot;
  //   //     .then((_) {
  //   //   ScaffoldMessenger.of(context).showSnackBar(
  //   //     const SnackBar(content: Text('Profile updated successfully')),
  //   //   );
  //   // }).catchError((error) {
  //   //   print('Error updating profile: $error');
  //   // });
  // }

  // Future<Users> fetchUser(String userId) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
  //       .collection('users')
  //       .doc(userId)
  //       .get();
  //   return Users.fromSnapshot(snapshot);
  // }

  @override
  Widget build(BuildContext context)  {
    final screenWidth1 = MediaQuery.of(context).size.width;
    screenWidth=screenWidth1;
    // final Users us = us.id;
    String userEmail = widget.snapshot['email'];
    // DocumentSnapshot<Map<String, dynamic>> p = await getUser();
    // List<Widget> pages=[Home_page(person,Top_saling,for_you),Favourite_page(person),Category_page(person,Categories),Cart_page(person),Profile_page(widget.snapshot)];
    List<Widget> pages=[Home_page(Top_saling,for_you),Favourite_page(userEmail, widget.snapshot),Category_page(Categories,userEmail),Cart_page(userEmail,),Profile_page(widget.snapshot)];

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(
            width: screenWidth*0.2,
            child: Text(
              '$app_name',
              style: const TextStyle(
                fontFamily: 'Sweety',
                color: Colors.black,
                fontSize: 27.0,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            '${listOfStrings[current_index]}',
            style: const TextStyle(
              fontFamily: 'Sweety',
              color: Colors.grey,
              fontSize: 30.0,
            ),
          ) ,
          elevation: 0,
          actions: [IconButton(
              onPressed: (){
                // notification page
              },
              icon: Stack(
                alignment: Alignment.topRight,
                children: [
                  Icon(
                    Icons.notifications_on_outlined,
                    size: 30,
                    color: Colors.grey,
                  ),
                  CircleAvatar(
                    backgroundColor: notification ? Colors.orange:Colors.transparent,
                    radius: 5,
                  )
                ],
              )
          ),
            SizedBox(
              width: 20.0,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor:online ,
                  radius: 22.0,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      '$Image_url'
                  ),
                  radius: 20.0,
                ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
          ]
      ),
      body:Container(
        color: Colors.white,
        child: pages.elementAt(current_index),
      ),

      bottomNavigationBar:Custom_NavBar(current_index,onTabTapped),
    );
  }
}