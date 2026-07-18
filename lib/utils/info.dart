import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String baseUrl = "http://madkr.tplinkdns.com:8080";
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

  static const String login_email = "login_email";
  static const String login_password = "login_password";
  static const String sort_open = "sort_open";
  static const String sort_apply = "sort_apply";
  static const String menu_qty_plus = "menu_qty_plus";
  static const String menu_addcart = "menu_addcart";
  static const String cart_qty_plus = "cart_qty_plus";
  static const String cart_qty_minus = "cart_qty_minus";
  static const String cart_order = "cart_order";
  static const String profile_address = "profile_address";
  static const String address_add = "address_add";
  static const String address_text = "address_text";
  static const String address_save = "address_save";
  static const String profile_check_logout = "profile_check_logout";
  static const String profile_logout = "profile_logout";
}
