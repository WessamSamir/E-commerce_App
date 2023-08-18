import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import '../models/Personal_info.dart';
import '../models/products.dart';
import '../widgets/Product_widget.dart';
class Home_page extends StatefulWidget {
  final Person_info user;
  List<products> home_products;
  Home_page(this.user,this.home_products);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  TextEditingController? search_value ;
  bool ispressed=true;
  String app_name='hello';
  bool notification= true;
  Color online=Colors.green;
  Color pressed=Color.fromRGBO(2, 63, 40, 1);
  List slideShow=["Assets/images/slider1.jpg",
    "Assets/images/Huge Sale Twitter Share Post Template - Made with PosterMyWall (2).gif"];
  String Image_url= "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  double screenWidth=0;
  List<products> Top_saling=[];
  List<products> for_you=[];
  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    List<Widget> Slidshow=slideShow.map((url) =>Image.asset(url),).toList();
    screenWidth=screenWidth1;
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
                            widget.home_products=Top_saling;
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
                            widget.home_products=for_you;
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
              itemBuilder: (context,index)=>Product_widget(widget.home_products[index],widget.user),
              separatorBuilder: (context,index)=>const SizedBox(
                height: 20.0,
              ),
              itemCount: widget.home_products.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,),
          ],
        ),
      ),
    );
  }
}
