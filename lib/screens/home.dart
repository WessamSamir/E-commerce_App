import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/screens/product_details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../models/Category.dart';
import '../models/Personal_info.dart';
import '../models/products.dart';
import 'Category.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  List<Color>barcolor=[Colors.white,
    Color.fromRGBO(255, 33, 131, 1.0),
    Colors.white,
    Colors.lightBlueAccent,
    Colors.white];

  List<IconData> listOfIcons = [
    FontAwesomeIcons.home,
    Icons.favorite,
    MdiIcons.earth,
    MdiIcons.cartOutline,
    FontAwesomeIcons.userCircle
  ];

  List<String> listOfStrings = [
    'Home',
    'favourite',
    'Explore',
    'Cart',
    'Account',
  ];
  double screenWidth=0;
  TextEditingController? search_value ;
  bool ispressed=true;
  String app_name='hello';
  bool notification= true;
  Color online=Colors.green;
  Color pressed=Color.fromRGBO(2, 63, 40, 1);
  List slideShow=["Assets/images/Sale Promotion Digital Display HD - Made with PosterMyWall.gif",
    "Assets/images/Huge Sale Twitter Share Post Template - Made with PosterMyWall (2).gif"];
  String Image_url= "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  int current_index=0;
  List<IconData> navbar_icons=[FontAwesomeIcons.home,MdiIcons.earth,MdiIcons.cartOutline,FontAwesomeIcons.userCircle];
  List<products> home_products=[
    products('Cookies', 50, 'https://th.bing.com/th/id/OIP.6e8n0Naqmwjg-IbT1UjkewHaE6?pid=ImgDet&rs=1','Food',false,false,
        "A cookie is a small sweet, crispy or cake-like pastry most often made with flour, sugar, liquid and fat. They are characterized by:"),
    products('Cookies', 50, 'https://th.bing.com/th/id/OIP.6e8n0Naqmwjg-IbT1UjkewHaE6?pid=ImgDet&rs=1','Food' ,false,false,
        "Cookies are baked treats. A cookie is a small sweet, crispy or cake-like pastry most often made with flour, sugar, liquid and fat. They are characterized by:"),
  ];
  List<Catego> cat=[
    Catego("Food", "Assets/images/food category.jpg"),
    Catego("Cloth", "Assets/images/clothes.jpg"),
    Catego("Mobiles", "Assets/images/Moblie category.jpg"),
    Catego("LapTop", "Assets/images/laptop.jpg"),
    Catego("Books", "Assets/images/book.jpg"),
  ];
  IconData pass_eye=MdiIcons.eyeLock;
  bool eye_pressed=false;
  String pass="*********";
  Color save_changes= Color.fromRGBO(1, 70, 66, 1.0);

  TextEditingController user_name=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  Person_info person=Person_info("Loay Mohamed", "01121510042", "looay432@gmail.com","2001369105694");
  String profile_image_path='';
  bool product_opend=false;

  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    screenWidth=screenWidth1;
    List<Widget> Slidshow=slideShow.map((url) =>Image.asset(url),).toList();
    List<Widget> pages=[home_page(screenWidth1, Slidshow,home_products),fav_page(screenWidth1,home_products),category_page(),cart_page(screenWidth,home_products),profile(person)];
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

      bottomNavigationBar:Container(
        margin: EdgeInsetsDirectional.all(screenWidth1*0.03),
        height: screenWidth1*0.2,
        decoration: BoxDecoration(

            color: Colors.black,
            borderRadius: BorderRadius.circular(screenWidth1*0.1)
        ),
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: screenWidth1 * .02),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context,index)=>navBar(index, screenWidth1)
        ),
      ),
    );

  }
  Widget product( products p)
  {
    return GestureDetector(
      onTap: (){
        setState(() {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetails(p,person)));
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.black,
        ),
        height: screenWidth*0.6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: screenWidth*0.6,
                child: Image.network(
                  '${p.product_img}',
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                '${p.category}',
                style: TextStyle(
                  fontFamily: 'Sweety',
                  color: Colors.white54,
                  fontSize:25.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${p.product_name}',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      color: Colors.white,
                      fontSize:30.0,
                    ),
                  ),
                  RatingBar.builder(
                    itemSize: 20.0,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsetsDirectional.all(4.0),
                    itemBuilder: (context, _) => Icon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.white,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          p.cart=!p.cart;
                          p.cart?person.cart.add(p):person.cart.remove(p);
                        });
                      },
                        icon: Icon(
                          Icons.shopping_cart_sharp,
                          color: p.cart? Colors.lightBlueAccent:Colors.white70,
                          size: 30.0,
                        ),
                      ),
                      Text(
                        '${p.product_price} \$ ',
                        style: TextStyle(
                          fontFamily: 'fastForward',
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          setState(() {
                            p.fav=!p.fav;
                            p.fav?person.fav.add(p):person.fav.remove(p);
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: p.fav? Color.fromRGBO(255, 33, 131, 1.0):Colors.white70,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget home_page( screenWidth,Slidshow,home_products)
  {
    return Padding(
      padding: EdgeInsetsDirectional.all(20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 20.0,
              ),
              child:Container(
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: Center(
                  child: TextField(
                    controller: search_value,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white12,
                          )
                      ),
                      prefixIcon: Icon(
                        FontAwesomeIcons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'Search Product',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),//search bar
            Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 20.0,
                ),
                child: Container(
                  width: screenWidth*0.89,
                  height: screenWidth*0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth*0.1),

                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(screenWidth*0.1),
                    child: ImageSlideshow(
                      children: Slidshow,
                      autoPlayInterval: 4000,
                    ),
                  ),
                )
            ), // slider
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: ispressed? pressed:Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: MaterialButton(
                        onPressed:(){
                          setState(() {
                            ispressed=true;
                          });
                        },
                        child: const Text(
                          'Top Selling',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontFamily: 'Amperzand'
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0,),
                  Expanded(
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: !ispressed? pressed:Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: MaterialButton(
                        onPressed:(){
                          setState(() {
                            ispressed=false;
                          });
                        },
                        child: const Text(
                          'For you',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontFamily: 'Amperzand'
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ), //buttons
            ListView.separated(
              itemBuilder: (context,index)=>product(home_products[index]),
              separatorBuilder: (context,index)=>const SizedBox(
                height: 20.0,
              ),
              itemCount: home_products.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,),
          ],
        ),
      ),
    );
  }

  Widget fav_page(screenWidth,home_products)
  {
    return Padding(
      padding: EdgeInsetsDirectional.all(20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListView.separated(
              itemBuilder: (context,index1)=>product(person.fav[index1]),
              separatorBuilder: (context,index)=>const SizedBox(
                height: 20.0,
              ),
              itemCount: person.fav.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,),
          ],
        ),
      ),
    );
  }
  Widget category_page()
  {
    return Padding(
      padding: EdgeInsetsDirectional.all(20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListView.separated(
              itemBuilder: (context,index1)=>category(cat[index1]),
              separatorBuilder: (context,index)=>const SizedBox(
                height: 20.0,
              ),
              itemCount: cat.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,),
          ],
        ),
      ),
    );
  }
  Widget cart_page(screenWidth,home_products)
  {
    return Padding(
      padding: EdgeInsetsDirectional.all(20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListView.separated(
              itemBuilder: (context,index1)=>Cart_product(person.cart[index1],index1),
              separatorBuilder: (context,index)=>const SizedBox(
                height: 20.0,
              ),
              itemCount: person.cart.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,),
          ],
        ),
      ),
    );
  }

  Widget category(Catego C)
  {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>category_product(home_products,person,C.name)));
      },
      child: Container(
        height: screenWidth*0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth*0.1),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth*0.1),
                child: Image.asset(C.pic,fit: BoxFit.cover,)
            ),
            Container(
              height: screenWidth*0.2,
              child: Text(
                '${C.name}',
                style: TextStyle(
                    fontFamily: "Sweety",
                    fontSize: screenWidth*0.09,
                    color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget navBar(index,screenWidth)
  {
    return InkWell(
      onTap: (){
        setState(() {
          current_index=index;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn,
            width: index == current_index
                ? screenWidth * .25
                : screenWidth * .05,
            alignment: Alignment.center,
            child:  AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn,
              height: index == current_index ? screenWidth * .2 : 0,
              width: index == current_index ? screenWidth * .25 : 0,
              decoration: BoxDecoration(
                color: index == current_index
                    ? Colors.teal.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(screenWidth*0.1),
              ),
            ),

          ),
          AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn,
            width: index == current_index
                ? screenWidth * .31
                : screenWidth * .15,
            alignment: Alignment.center,
            child: Stack(
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width:
                      index == current_index  ? screenWidth * .13 : 0,
                    ),
                    AnimatedOpacity(
                      opacity: index == current_index  ? 1 : 0,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Text(
                        index == current_index
                            ? '${listOfStrings[index]}'
                            : '',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth*0.03,
                            fontFamily: 'Amperzand'
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width:
                      index == current_index ? screenWidth * .03 : 20,
                    ),
                    Icon(
                      listOfIcons[index],
                      size: screenWidth * .072,
                      color: index == current_index
                          ? barcolor[index]
                          : Colors.white60,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget Cart_product( products p,index)
  {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(screenWidth*0.05),
            color: index%2==0? Colors.black12:Color.fromRGBO(1, 126, 120, 1.0),
          ),
          height: screenWidth*0.4,
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
                          width: screenWidth*0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(screenWidth*0.05),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(screenWidth*0.05),
                            child: Image.network(p.product_img,fit: BoxFit.cover,),
                          ),
                        ),
                        Container(
                          width: screenWidth*0.13,
                          height: screenWidth*0.13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(screenWidth*0.05),
                              bottomRight: Radius.circular(screenWidth*0.05),
                            ),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              '${p.product_price} \$ ',
                              style: TextStyle(
                                fontFamily: 'fastForward',
                                fontSize: screenWidth*0.02,
                                color: Color.fromRGBO(225, 162, 1, 1.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: screenWidth*0.05,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${p.product_name}',
                            style: TextStyle(
                              fontFamily: 'Amperzand',
                              fontSize: screenWidth*0.07,
                              fontWeight: FontWeight.w200,
                              color: index%2==0?Colors.black:Colors.white,
                            ),
                          ),
                          Text(
                            '${p.amount}',
                            style: TextStyle(
                                fontSize: screenWidth*0.05,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Sweety',
                                color:Colors.grey
                            ),
                          ),
                          SizedBox(
                            height: screenWidth*0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    p.amount++;
                                  });
                                },
                                child: Container(
                                  width: screenWidth*0.1,
                                  height: screenWidth*0.1,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: Icon(Icons.add,color: Colors.white,),
                                ),
                              ),
                              SizedBox(width: screenWidth*0.015,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    p.amount >1?p.amount--:p.amount;
                                  });
                                },
                                child: Container(
                                  width: screenWidth*0.1,
                                  height: screenWidth*0.1,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: Icon(Icons.remove,color: Colors.white,),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenWidth*0.05,),
                  ],
                ),
              ),
              Container(
                width: screenWidth*0.13,
                height: screenWidth*0.13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight:Radius.circular(screenWidth*0.05),
                    bottomLeft: Radius.circular(screenWidth*0.05),
                  ),
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: Center(
                  child: IconButton(onPressed: (){
                    setState(() {
                      p.cart=!p.cart;
                      if(!p.cart)
                        person.cart.remove(p);
                    });
                  },
                    icon: Icon(
                      Icons.shopping_cart_sharp,
                      color: p.cart? Colors.lightBlueAccent:Colors.white70,
                      size: screenWidth*0.06,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
  Widget product_info(products p)
  {
    List<Color> size_color=[Colors.black12,Colors.black12,Colors.black12];
    List <bool> size_pressed=[false,false,false];
    int counter = 0;
    bool addedToFavorite = false;
    Color favColor = Colors.cyan;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth*0.1),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.network(p.product_img),
                    Column(
                      children: [
                        RatingBar.builder(
                          itemSize: 30.0,
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsetsDirectional.all(4.0),
                          itemBuilder: (context, _) => Icon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.white60,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        SizedBox(height: screenWidth*0.05,)
                      ],
                    ),
                  ],
                )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${p.product_price} \$",
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontFamily: "fastForward"
                ),
              ),
              Row(
                children: [
                  InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: (){
                      setState(() {
                        size_pressed[0]=true;
                        size_pressed.fillRange(1,3,false);
                        size_color[0]=size_pressed[0]?Colors.black:Colors.black12;
                        size_color[1]=size_pressed[1]?Colors.black:Colors.black12;
                        size_color[2]=size_pressed[2]?Colors.black:Colors.black12;
                      });
                    },
                    child: Container(
                      height: screenWidth*0.19,
                      width: screenWidth*0.16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(screenWidth*0.05),
                        border: Border.all(width: 1.5,color:size_color[0]),
                      ),
                      child: Center(
                        child: Text(
                          'S',
                          style: TextStyle(
                            fontFamily: "fastForward",
                            fontSize: screenWidth*0.04,
                            color: size_color[0],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth*0.05,),
                  InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: (){
                      setState(() {
                        size_pressed.fillRange(0,3,false);
                        size_pressed[1]=true;
                        size_color[0]=size_pressed[0]?Colors.black:Colors.black12;
                        size_color[1]=size_pressed[1]?Colors.black:Colors.black12;
                        size_color[2]=size_pressed[2]?Colors.black:Colors.black12;
                      });
                    },
                    child: Container(
                      height: screenWidth*0.19,
                      width: screenWidth*0.16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(screenWidth*0.05),
                        border: Border.all(width: 1.5,color:size_color[1]),
                      ),
                      child: Center(
                        child: Text(
                          'L',
                          style: TextStyle(
                            fontFamily: "fastForward",
                            fontSize: screenWidth*0.04,
                            color: size_color[1],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth*0.05,),
                  InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: (){
                      setState(() {
                        size_pressed.fillRange(0,3,false);
                        size_pressed[2]=true;
                        size_color[0]=size_pressed[0]?Colors.black:Colors.black12;
                        size_color[1]=size_pressed[1]?Colors.black:Colors.black12;
                        size_color[2]=size_pressed[2]?Colors.black:Colors.black12;
                      });
                    },
                    child: Container(
                      height: screenWidth*0.19,
                      width: screenWidth*0.16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(screenWidth*0.05),
                        border: Border.all(width: 1.5,color:size_color[2]),
                      ),
                      child: Center(
                        child: Text(
                          'XL',
                          style: TextStyle(
                            fontFamily: "fastForward",
                            fontSize: screenWidth*0.04,
                            color: size_color[2],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(18.0),
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(1, 56, 36, 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.0,),
                      Text(
                        "${p.rating}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(18.0),
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 54, 39, 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        p.fav=!p.fav;
                        p.fav?person.fav.add(p):person.fav.remove(p);
                      });
                    },
                    child: Container(
                      child: Icon(
                        p.fav ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),
                Container(
                  width: 350,

                  child:  ExpansionTile(
                    title: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    children: [
                      Text(
                        //widget.product.description,
                        "${p.description}",
                        style:  TextStyle(
                            height: 1.5,
                            wordSpacing: 5,
                            color: Colors.black54,
                            fontSize: 20,
                            fontFamily: "Amperzand"
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 350,
                  child: const ExpansionTile(
                    title: Text(
                      "Returned Policy",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    children: [
                      Text(
                        //widget.product.policy,
                        "Returned Policy here",
                        style: TextStyle(
                            height: 1.5,
                            wordSpacing: 5,
                            color: Colors.black54,
                            fontSize: 20,
                            fontFamily: "Amperzand"),

                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 38,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: (){
                              setState(() {
                                if(counter > 0) {
                                  counter--;
                                }
                              });
                            },
                            child: const Text(
                              "-",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Text(
                            "$counter",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                              setState(() {
                                counter++;
                              });
                            },
                            child: const Text(
                              "+",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                          p.cart=true;
                          person.cart.add(p);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan.shade500,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        "add to cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget profile(Person_info p)
  {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 0.6*screenWidth,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.2*screenWidth),
                        color: Colors.black
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0.2*screenWidth),
                      child: Image.asset("Assets/Images/image_processing20200825-24260-1l1hr8o.gif",fit: BoxFit.cover,),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                          height: screenWidth*0.9,
                          width: screenWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(screenWidth*0.2),
                              color: Colors.transparent
                          )),
                      Container(
                        width: screenWidth*0.28*2,
                        height: screenWidth*0.28*2,
                        decoration: BoxDecoration(
                            color:Colors.black,
                            shape: BoxShape.circle
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black54,
                              radius: screenWidth*0.28,
                              child: CircleAvatar(
                                radius: screenWidth*0.27,
                                backgroundImage: profile_image_path==''? AssetImage(
                                  "Assets/Images/image_processing20210910-22853-1777qya.gif",
                                ):Image.file(File(profile_image_path) ).image,
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectImage();
                                });
                              },
                              child: CircleAvatar(
                                backgroundImage: AssetImage("Assets/images/camera.png"),
                                radius: screenWidth*0.09,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenWidth*0.04,),
              Text(
                'Loay',
                style: TextStyle(
                  fontSize: screenWidth*0.1,
                  fontFamily: "sweety",
                  color: Colors.black12,
                ),
              ),
              SizedBox(height: screenWidth*0.04,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth*0.05),
                  color: Colors.black12,
                ),
                child: TextField(
                  controller: user_name,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(1, 126, 120, 1.0),
                            width: 2
                        ),
                        borderRadius: BorderRadius.circular(screenWidth*0.05),
                      ),
                      hintText: "${p.name}",
                      hintStyle: TextStyle(
                        overflow: TextOverflow.fade,
                        fontFamily: 'Amperzand',
                        fontSize: screenWidth*0.05,
                        color: Colors.white,
                      ),
                      labelText: "user name",
                      labelStyle: TextStyle(
                        fontSize: screenWidth*0.06,
                        fontFamily: "Sweety",

                      ),
                      prefixIcon: Icon(FontAwesomeIcons.userCircle,
                        color: Colors.black,)
                  ),
                ),
              ),
              SizedBox(height: screenWidth*0.04,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth*0.05),
                  color: Colors.black12,
                ),
                child: TextField(
                  controller: phone,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(1, 126, 120, 1.0),
                            width: 2
                        ),
                        borderRadius: BorderRadius.circular(screenWidth*0.05),
                      ),
                      hintText: "${p.phone}",
                      hintStyle: TextStyle(
                        overflow: TextOverflow.fade,
                        fontFamily: 'Amperzand',
                        fontSize: screenWidth*0.05,
                        color: Colors.white,
                      ),
                      labelText: "phone number",
                      labelStyle: TextStyle(
                        fontSize: screenWidth*0.06,
                        fontFamily: "Sweety",

                      ),
                      prefixIcon: Icon(FontAwesomeIcons.phoneVolume,
                        color: Colors.black,)
                  ),
                ),
              ),
              SizedBox(height: screenWidth*0.04,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth*0.05),
                  color: Colors.black12,
                ),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(1, 126, 120, 1.0),
                            width: 2
                        ),
                        borderRadius: BorderRadius.circular(screenWidth*0.05),
                      ),
                      hintText: "${p.mail}",
                      hintStyle: TextStyle(
                        overflow: TextOverflow.fade,
                        fontFamily: 'Amperzand',
                        fontSize: screenWidth*0.05,
                        color: Colors.white,
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: screenWidth*0.06,
                        fontFamily: "Sweety",

                      ),
                      prefixIcon: Icon(MdiIcons.emailBox,
                        color: Colors.black,)
                  ),
                ),
              ),
              SizedBox(height: screenWidth*0.04,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth*0.05),
                  color: Colors.black12,
                ),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(1, 126, 120, 1.0),
                            width: 2
                        ),
                        borderRadius: BorderRadius.circular(screenWidth*0.05),
                      ),
                      hintText: "$pass",
                      hintStyle: TextStyle(
                        overflow: TextOverflow.fade,
                        fontFamily: 'Amperzand',
                        fontSize: screenWidth*0.05,
                        color: Colors.white,
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: screenWidth*0.06,
                        fontFamily: "Sweety",

                      ),
                      prefixIcon: Icon(Icons.password_sharp,
                        color: Colors.black,),
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            eye_pressed=!eye_pressed;
                            pass_eye=eye_pressed?MdiIcons.eyeCheck:MdiIcons.eyeLock;
                            pass=eye_pressed?p.password:"*********";
                          });
                        },
                        icon: Icon(pass_eye),
                      )
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: screenWidth*0.06,),
              MaterialButton(
                onPressed: (){
                  setState(() {
                    save_changes=Color.fromRGBO(1, 126, 120, 1.0);
                    p.name=user_name.text!=''?user_name.text:p.name;
                    p.phone=phone.text!=''?phone.text:p.phone;
                    p.mail=email.text!=''?email.text:p.mail;
                    p.password=password.text!=''?password.text:p.password;
                    print(user_name.text);
                    print(p.name);

                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87,width: 2),
                    borderRadius: BorderRadius.circular(screenWidth*0.05),
                    color: save_changes,
                  ),
                  width: screenWidth*0.5,
                  height: screenWidth*0.2,
                  child: Center(
                      child: Text(
                        'Save changes',
                        style: TextStyle(
                            fontFamily: "Amperzand",
                            fontSize: screenWidth*0.09,
                            color: Colors.white
                        ),
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future selectImage()
  {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
                height: screenWidth*0.7,
                child:Padding(
                  padding: EdgeInsetsDirectional.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Choose the photo source',
                        style: TextStyle(
                          fontSize: screenWidth*0.06,
                          fontFamily: "Amperzand",
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(height: screenWidth*0.1,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: ()async{
                                  profile_image_path=await wallpaper();
                                  if(profile_image_path.isNotEmpty)
                                  {
                                    Navigator.pop(context);
                                    setState(() {
                                    });
                                  }
                                },
                                child: Container(
                                    width: screenWidth*0.2,
                                    height: screenWidth*0.2,
                                    child: Image.asset("Assets/images/wallpaper.png")
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                'Wallpaper',
                                style: TextStyle(
                                  fontFamily: 'Sweety',
                                  fontSize: screenWidth*0.06,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: ()async{
                                  profile_image_path=await camera();
                                  if(profile_image_path.isNotEmpty)
                                  {
                                    Navigator.pop(context);
                                    setState(() {
                                    });
                                  }
                                },
                                child: Container(
                                    width: screenWidth*0.2,
                                    height: screenWidth*0.2,
                                    child: Image.asset("Assets/images/camera (1).png")
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                'Camera',
                                style: TextStyle(
                                  fontFamily: 'Sweety',
                                  fontSize: screenWidth*0.06,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )

            ),
          );
        }
    );
  }
  wallpaper() async{
    XFile? image_file= await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 10);
    if(image_file!=null)
      return image_file.path;
    else
      return '';
  }

  camera() async{
    XFile? image_file= await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 10);
    if(image_file!=null)
      return image_file.path;
    else
      return '';
  }
}


