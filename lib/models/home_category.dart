import 'dart:ui';

import 'package:flutter/material.dart';

class HomeCategoryModel {
  String? text;
  Color? textColor;
  Color? borderColor;

  HomeCategoryModel(
      {this.textColor = Colors.grey,
      this.borderColor = Colors.transparent,
      required this.text});
}
