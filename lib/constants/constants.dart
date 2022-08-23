import 'package:flutter/material.dart';
import 'package:life/models/posts_model.dart';

import '../models/notification_model.dart';
import '../models/products_model.dart';

const Color defaultColor = Color(0xff1AAA02);
const Color transparentColor = Colors.transparent;
String token = "";
String baseUrlForImage = "https://lavie.orangedigitalcenteregypt.com";
List<ProductsData> allProducts = [];
List<int> productsQuantity = [];

List<NotificationModel> notificationList = [
  NotificationModel(
      imageUrl: 'assets/images/Joy.png',
      title: 'Joy Arnold left 6 comments on Your Post',
      time: 'Yesterday at 11:42 PM'),
  NotificationModel(
      imageUrl: 'assets/images/Dennis.png',
      title: 'Dennis Nedry commented on Isla Nublar SOC2 compliance report',
      text:
      "“ leaves are an integral part of the stem system. They are attached by a continuous vascular system to the rest of the plant so that free exchange of nutrients.”",
      time: 'Yesterday at 5:42 PM'),
  NotificationModel(
      imageUrl: 'assets/images/John.png',
      title: 'John Hammond created Isla Nublar SOC2 compliance report  ',
      time: 'Wednesday at 11:15 AM'),
];
