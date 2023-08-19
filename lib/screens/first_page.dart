import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/login.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  double screenWidth=0;
  double screenheight=0;
  List slideShow=["Assets/images/intial image2.jpg",
    "Assets/images/intial image.jpg"];
  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    final screenheight1 = MediaQuery.of(context).size.height;
    List<Widget> Slidshow=slideShow.map((url) =>Image.asset(url),).toList();
    screenWidth=screenWidth1;
    screenheight=screenheight1;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: screenheight1,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: ImageSlideshow(
              children: Slidshow,
              autoPlayInterval: 4000,
            ),
          ),

          GestureDetector(

            onVerticalDragUpdate: (dragUpdateDetails) {
              if (dragUpdateDetails.delta.dy < 1) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              }
            },
            child: Container(
              height: screenheight1*0.3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("Assets/images/double-arrow.gif"),
                    SizedBox(height: 20,),
                    Text(
                      'Swipe Up to Signin',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white60,
                          fontFamily: "Sweety"
                      ),

                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}