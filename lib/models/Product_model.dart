
class ProductModel {
  final String userEmail;
  final String product_name;
  final int product_price;
  final String product_img;
  late bool fav = false;
  late bool cart= false;
  int quantity = 1;

  ProductModel(
      {required this.userEmail,
      required this.product_name,
      required this.product_price,
      required this.product_img,
        required this.quantity,
      });


}
