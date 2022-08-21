class ProductDetailsModel {
  String text = "";
  int detailsNumber = 0;
  String? imageUrl;

  ProductDetailsModel(
      {required this.imageUrl,
        required this.text,
        required this.detailsNumber});
}
