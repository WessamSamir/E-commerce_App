import 'package:flutter/material.dart';
import 'package:flutter_demo/models/Products.dart';

class CartItem extends ChangeNotifier {
  List<Products> product = [];

  addProduct(Products prod) {
    product.add(prod);
    notifyListeners();
  }
}