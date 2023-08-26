import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/Product_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/Users.dart';
import '../models/Products.dart';
import '../screens/product_details.dart';
import '../services/store.dart';

class Product_widget extends StatefulWidget {
  final DocumentSnapshot snapshot;
final String userEmail;
  final Products product;
  const Product_widget(this.product, this.userEmail, this.snapshot);

  @override
  State<Product_widget> createState() => _Product_widgetState();
}

class _Product_widgetState extends State<Product_widget> {
  double screenWidth=0;
Store store = Store();


  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    screenWidth=screenWidth1;
    return  GestureDetector(
      onTap: (){
        setState(() {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetails(widget.product,widget.userEmail, widget.snapshot)));
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
              SizedBox(
                height: screenWidth*0.6,
                child: Image.network(
                  widget.product.product_img,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                widget.product.category,
                style: const TextStyle(
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
                    widget.product.product_name,
                    style: const TextStyle(
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
                    itemPadding: const EdgeInsetsDirectional.all(4.0),
                    itemBuilder: (context, _) => const Icon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.white,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: () async {
                        if(await store.checkProductExists(widget.product, widget.snapshot))
                        {
                        print('exist and delete');
                        widget.product.cart= false;
                        store.deleteProduct(widget.snapshot,widget.product.product_name);
                        }else {
                        print('not exist');
                        widget.product.cart = true;
                        store.addToCart(widget.product,widget.snapshot);
                        }
                        setState(() {

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
                        style: const TextStyle(
                          fontFamily: 'fastForward',
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          widget.product.fav = false;
                          store.UnFavProduct(widget.snapshot, widget.product.product_name);
                          setState(() {
                            // widget.product.fav=!widget.product.fav;
                            // widget.product.fav?widget.product.fav=true:widget.product.fav=false;
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: widget.product.fav? const Color.fromRGBO(255, 33, 131, 1.0):Colors.white70,
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
