import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileModel {
  String text = "";
  String? labelText1;
  String? labelText2 = 'Enter last Name';
  Image? image = Image.asset('assets/images/profileIcon.png');
  void Function() acceptFn;
  TextEditingController? controller1;
  TextEditingController? controller2;
  bool? changeName;

  ProfileModel(
      {required this.text,
      this.labelText1,
      this.labelText2,
      required this.acceptFn,
      this.controller1,
      this.controller2,
      this.changeName});
}
