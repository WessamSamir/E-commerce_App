import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/Category_products.dart';
import '../models/Category.dart';
import '../models/Personal_info.dart';
import '../models/products.dart';

class Category_page extends StatefulWidget {
  final Person_info user;
  final List<List<products>> Categories;
  const Category_page(this.user,this.Categories );

  @override
  State<Category_page> createState() => _Category_pageState();
}

class _Category_pageState extends State<Category_page> {
  double screenWidth=0;
  List<Catego> cat=[
    Catego("Food", "Assets/images/food category.jpg"),
    Catego("Cloth", "Assets/images/clothes.jpg"),
    Catego("Mobiles", "Assets/images/Moblie category.jpg"),
    Catego("LapTop", "Assets/images/laptop.jpg"),
    Catego("Books", "Assets/images/book.jpg"),
  ];

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
              itemBuilder: (context,index1)=>category(cat[index1],index1),
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
  Widget category(Catego C,index)
  {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>category_product(widget.Categories[index],widget.user,C.name)));
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

}
