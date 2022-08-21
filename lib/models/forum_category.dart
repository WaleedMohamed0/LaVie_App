import 'dart:ui';

import 'package:flutter/material.dart';

class ForumsCategoryModel {
  String? text;
  Color? textColor;
  Color? borderColor;
  Color? fillColor;

  ForumsCategoryModel(
      {this.textColor = Colors.grey,
      this.borderColor = Colors.transparent,
      required this.text,this.fillColor=Colors.transparent});
}
