class MyCartProducts {
  String name = "", imageUrl = "";
  int productPrice = 0,
      totalProductPrice = 0,
      quantity = 0,
      id = 0;

  MyCartProducts(
      {required this.name,
      required this.imageUrl,
      required this.id,
      required this.quantity,
      required this.productPrice,
      required this.totalProductPrice,});
}
