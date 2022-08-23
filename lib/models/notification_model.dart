class NotificationModel {
  String imageUrl = "", text, title = "", time = "";

  NotificationModel(
      {this.text = "",
      required this.imageUrl,
      required this.title,
      required this.time});
}
