class products{
  final String product_name;
  final int product_price;
  final String product_img;
  final String category;
  final String description;
  late bool fav;
  late bool cart;
  int amount=1;

  products(bool fav, bool cart, {required this.product_name, required this.product_price, required this.product_img, required this.category, required this.description});
}