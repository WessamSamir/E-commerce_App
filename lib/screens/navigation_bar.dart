import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class Custom_NavBar extends StatefulWidget {
  int current_index;
  final Function(int) onIndexChanged;
  Custom_NavBar(this.current_index,this.onIndexChanged);

  @override
  State<Custom_NavBar> createState() => _Custom_NavBarState();
}

class _Custom_NavBarState extends State<Custom_NavBar> {
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

  @override
  Widget build(BuildContext context) {
    final screenWidth1 = MediaQuery.of(context).size.width;
    screenWidth=screenWidth1;
    return Container(
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
    );
  }
  Widget navBar(index,screenWidth)
  {
    return InkWell(
      onTap: (){
        setState(() {
          //widget.current_index=index;
          widget.onIndexChanged(index);
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn,
            width: index == widget.current_index
                ? screenWidth * .25
                : screenWidth * .05,
            alignment: Alignment.center,
            child:  AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn,
              height: index == widget.current_index ? screenWidth * .2 : 0,
              width: index == widget.current_index ? screenWidth * .25 : 0,
              decoration: BoxDecoration(
                color: index == widget.current_index
                    ? Colors.teal.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(screenWidth*0.1),
              ),
            ),

          ),
          AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn,
            width: index == widget.current_index
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
                      index == widget.current_index  ? screenWidth * .13 : 0,
                    ),
                    AnimatedOpacity(
                      opacity: index == widget.current_index  ? 1 : 0,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Text(
                        index == widget.current_index
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
                      index == widget.current_index ? screenWidth * .03 : 20,
                    ),
                    Icon(
                      listOfIcons[index],
                      size: screenWidth * .072,
                      color: index == widget.current_index
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
}
