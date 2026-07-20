import 'package:flutter/material.dart';

String baseUrl = "madkr.tplinkdns.com:8080";
String token = '';
final headers = {"Authorization": "Bearer $token"};

bool get isLogin => token.isNotEmpty;

ValueNotifier<int> id = ValueNotifier(0);
ValueNotifier<String> email = ValueNotifier("");
ValueNotifier<String> name = ValueNotifier("");
ValueNotifier<String> grade = ValueNotifier("");

Color mainColor = Color(0xfffd9400);
Color subColor = Color(0xff6a717f);

OutlineInputBorder border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide(
    color: subColor.withOpacity(0.2),
    width: 1.5,
  ),
);
