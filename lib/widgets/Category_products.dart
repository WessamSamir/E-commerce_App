import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/Personal_info.dart';
import '../models/products.dart';
import '../screens/product_details.dart';

class category_product extends StatefulWidget {
  final List <products> p;
  final Person_info user;
  final String category_name;
  category_product(this.p,this.user,this.category_name);


  @override
  State<category_product> createState() => _category_productState();
}

class _category_productState extends State<category_product> {
  double screenWidth=0;
  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    screenWidth=screenWidth1;
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
        leading:  BackButton(
          color: Colors.cyan,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ListView.separated(
                itemBuilder: (context,index)=>product(widget.p[index]),
                separatorBuilder: (context,index)=>const SizedBox(
                  height: 20.0,
                ),
                itemCount: widget.p.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,),
            ],
          ),
        ),
      ),
    );
  }
  Widget product( products p)
  {
    return GestureDetector(
      onTap: (){
        setState(() {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetails(p,widget.user)));
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
                    width: screenWidth*0.7,
                    height: screenWidth*0.6,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(screenWidth*0.2),
                      image: DecorationImage(image: AssetImage("Assets/Images/beautiful-night-sky-with-shiny-stars.jpg"),fit: BoxFit.cover),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: (){
                          setState(() {
                            p.fav=!p.fav;
                            p.fav?widget.user.fav.add(p):widget.user.fav.remove(p);
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: p.fav? Color.fromRGBO(255, 33, 131, 1.0):Colors.white70,
                          size: 30.0,
                        ),
                      ),
                      IconButton(onPressed: (){
                        setState(() {
                          p.cart=!p.cart;
                          p.cart?widget.user.cart.add(p):widget.user.cart.remove(p);
                        });
                      },
                        icon: Icon(
                          Icons.shopping_cart_sharp,
                          color: p.cart? Colors.lightBlueAccent:Colors.white70,
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
            radius: screenWidth*0.3,
            backgroundImage: NetworkImage("${p.product_img}"),
            child: CircleAvatar(
              radius: screenWidth*0.3,
              backgroundImage: AssetImage("Assets/Images/green-screen-110341-540p--unscreen.gif"),
              backgroundColor: Colors.transparent,
            ),
          ),
          Container(
            width: 140*2,
            height: 140*2,

            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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

                        Text(
                          '${p.product_price} \$ ',
                          style: TextStyle(
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
