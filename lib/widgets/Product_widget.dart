import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/Personal_info.dart';
import '../models/products.dart';
import '../screens/product_details.dart';

class Product_widget extends StatefulWidget {
  final Person_info user;
  final products product;
  const Product_widget(this.product,this.user);

  @override
  State<Product_widget> createState() => _Product_widgetState();
}

class _Product_widgetState extends State<Product_widget> {
  double screenWidth=0;
  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    screenWidth=screenWidth1;
    return  GestureDetector(
      onTap: (){
        setState(() {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetails(widget.product,widget.user)));
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
                  '${widget.product.product_img}',
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                '${widget.product.category}',
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
                    '${widget.product.product_name}',
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
                          widget.product.cart=!widget.product.cart;
                          widget.product.cart?widget.user.cart.add(widget.product):widget.user.cart.remove(widget.product);
                        });
                      },
                        icon: Icon(
                          Icons.shopping_cart_sharp,
                          color: widget.product.cart? Colors.lightBlueAccent:Colors.white70,
                          size: 30.0,
                        ),
                      ),
                      Text(
                        '${widget.product.product_price} \$ ',
                        style: TextStyle(
                          fontFamily: 'fastForward',
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          setState(() {
                            widget.product.fav=!widget.product.fav;
                            widget.product.fav?widget.user.fav.add(widget.product):widget.user.fav.remove(widget.user);
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: widget.product.fav? Color.fromRGBO(255, 33, 131, 1.0):Colors.white70,
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
    );;
  }
}
