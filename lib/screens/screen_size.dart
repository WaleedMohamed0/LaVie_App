import 'package:flutter/cupertino.dart';

class Screen {
  static late double width, height;

  Screen(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  static get getScreenWidth {
  return width;
  }

  static get getScreenHeight {
    return height;
  }
}
