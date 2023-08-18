import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/screens/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../models/Personal_info.dart';
import '../models/products.dart';
import 'Home_page.dart';
import 'cart.dart';
import 'category_page.dart';
import 'favourite_page.dart';
import 'navigation_bar.dart';
class InitialPage extends StatefulWidget {
  // final String userId;
  final DocumentSnapshot snapshot;
  InitialPage({super.key, required this.snapshot});

  @override
  State<InitialPage> createState() => _InitialPage();
}

class _InitialPage extends State<InitialPage> {


  double screenWidth=0;
  String app_name='hello';
  bool notification= true;
  Color online=Colors.green;
  String Image_url= "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  int current_index=0;
  List<IconData> navbar_icons=[FontAwesomeIcons.home,MdiIcons.earth,MdiIcons.cartOutline,FontAwesomeIcons.userCircle];
  List<products> home_products=[
    products('Cookies', 50, 'https://th.bing.com/th/id/OIP.6e8n0Naqmwjg-IbT1UjkewHaE6?pid=ImgDet&rs=1','Food',false,false,
        "A cookie is a small sweet, crispy or cake-like pastry most often made with flour, sugar, liquid and fat. They are characterized by:"),
    products('Cookies', 50, 'https://th.bing.com/th/id/OIP.6e8n0Naqmwjg-IbT1UjkewHaE6?pid=ImgDet&rs=1','Food' ,false,false,
        "Cookies are baked treats. A cookie is a small sweet, crispy or cake-like pastry most often made with flour, sugar, liquid and fat. They are characterized by:"),
  ];

  Person_info person=Person_info("Loay Mohamed", "01121510042", "looay432@gmail.com","2001369105694");
  List<List<products>> Categories=[[products('Cookies', 50, 'https://th.bing.com/th/id/OIP.6e8n0Naqmwjg-IbT1UjkewHaE6?pid=ImgDet&rs=1','Food',false,false,
      "A cookie is a small sweet, crispy or cake-like pastry most often made with flour, sugar, liquid and fat. They are characterized by:"),]];
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

  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    screenWidth=screenWidth1;
    List<Widget> pages=[Home_page(person,home_products),Favourite_page(person),Category_page(person,Categories),Cart_page(person),Profile_page(widget.snapshot)];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Text(
                '$app_name',
                style: const TextStyle(
                  fontFamily: 'Sweety',
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),
              SizedBox(width: screenWidth1*0.1,),
              Text(
                '${listOfStrings[current_index]}',
                style: const TextStyle(
                  fontFamily: 'Sweety',
                  color: Colors.grey,
                  fontSize: 30.0,
                ),
              ),

            ],
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


