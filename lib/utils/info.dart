import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String baseUrl = "http://127.0.0.1:8080";
String tkn = "";

bool get isLogin => tkn.isNotEmpty;

ValueNotifier<int> id = ValueNotifier(0);
ValueNotifier<String> email = ValueNotifier("");
ValueNotifier<String> name = ValueNotifier("");
ValueNotifier<String> grade = ValueNotifier("");

Color mainColor = Color(0xfffd9400);
Color subColor = Color(0xff9ba2ae);

OutlineInputBorder border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide(color: subColor, width: 1.5),
);

TextStyle hintTextSt = TextStyle(
  color: subColor,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

class Keys {
  static const String tab_profile = "tab_profile";
  static const String button_login = "button_login";
  static const String try_login = "try_login";
  static const String tab_home = "tab_home";
  static const String tab_chicken = "tab_chicken";
  static const String tab_snack = "tab_snack";
  static const String tab_star = "tab_star";
  static const String tab_frist_card = "tab_frist_card";
  static const String tab_heart_on = "tab_heart_on";
  static const String tab_heart_off = "tab_heart_off";
  static const String tab_heart_again = "tab_heart_again";
  static const String tab_menu = "tab_menu";
  static const String tab_cart = "tab_cart";
}
