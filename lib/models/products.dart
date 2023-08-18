// class products{
//   final String product_name;
//   final int product_price;
//   final String product_img;
//   final String category;
//   final String description;
//   bool fav = false;
//   bool cart = false;
//   int amount=1;
//
//   products(bool fav, bool cart, {required this.product_name, required this.product_price, required this.product_img, required this.category, required this.description});
// }

class products{
  late final String product_name;
  late final int product_price;
  late final String product_img;
  late final String category;
  late bool fav;
  late bool cart;
  int amount=1;
  late double rating=0;
  late final String description;
  late String size;

  products(this.product_name, this.product_price, this.product_img, this.category,this.fav,this.cart,this.description);
}