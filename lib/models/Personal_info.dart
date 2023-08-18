import 'package:flutter_demo/models/products.dart';

class Person_info
{
  late String name;
  late String phone;
  late String mail;
  late String password;
  late String image;
  List<products> cart=[];
  List<products> fav=[];
  Person_info(this.name,this.phone,this.mail,this.password);
}