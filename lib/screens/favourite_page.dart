import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/Personal_info.dart';
import '../widgets/Product_widget.dart';

class Favourite_page extends StatefulWidget {
  final Person_info user;
  const Favourite_page( this.user );

  @override
  State<Favourite_page> createState() => _Favourite_pageState();
}

class _Favourite_pageState extends State<Favourite_page> {
  double screenWidth=0;
  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    screenWidth=screenWidth1;
    return Padding(
      padding: EdgeInsetsDirectional.all(20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListView.separated(
              itemBuilder: (context,index1)=>Product_widget(widget.user.fav[index1],widget.user),
              separatorBuilder: (context,index)=>const SizedBox(
                height: 20.0,
              ),
              itemCount: widget.user.fav.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,),
          ],
        ),
      ),
    );
  }
}
