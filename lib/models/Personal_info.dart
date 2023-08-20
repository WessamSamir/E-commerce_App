import 'package:flutter_demo/models/Products.dart';

class Person_info
{
  late String name;
  late String phone;
  late String mail;
  late String password;
  late String image;
  List<Products> cart=[];
  List<Products> fav=[];
  Person_info(this.name,this.phone,this.mail,this.password);
}