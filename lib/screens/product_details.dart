import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/Personal_info.dart';
import '../models/products.dart';
import 'Initial_page.dart';



class ProductDetails extends StatefulWidget {
  final products product;
  final Person_info user;
  const ProductDetails( this.product,this.user );

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<Color> size_color=[Colors.black12,Colors.black12,Colors.black12];
  List <bool> size_pressed=[false,false,false];
  int counter = 0;
  bool addedToFavorite = false;
  Color favColor = Colors.cyan;


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.product_name,
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
      body: SingleChildScrollView(
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
                      Image.network(widget.product.product_img),
                      Column(
                        children: [
                          RatingBar.builder(
                            itemSize: 30.0,
                            initialRating: widget.product.rating,
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
                              widget.product.rating=rating;
                              setState(() {

                              });
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
                  "${widget.product.product_price} \$",
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
                          widget.product.size="S";
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
                          widget.product.size="L";
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
                          widget.product.size="XL";
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
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(1, 56, 36, 1.0),
                      borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10.0,),
                        Text(
                          "${widget.product.rating}",
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
                          widget.product.fav=!widget.product.fav;
                          widget.product.fav?widget.user.fav.add(widget.product):widget.user.fav.remove(widget.product);
                        });
                      },
                      child: Container(
                        child: Icon(
                          widget.product.fav ? Icons.star : Icons.star_border,
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
                          "${widget.product.description}",
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
                                  if(widget.product.amount > 0) {
                                    widget.product.amount--;
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
                              "${widget.product.amount}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                setState(() {
                                  widget.product.amount++;
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
                            widget.product.cart=true;
                            widget.user.cart.add(widget.product);
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
      ),
    );
  }
}