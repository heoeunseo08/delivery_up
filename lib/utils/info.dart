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

bool testMode = false;

class Keys {
  static const ValueKey step2 = ValueKey("step2");
  static const ValueKey step3 = ValueKey("step3");
  static const ValueKey step4 = ValueKey("step4");
  static const ValueKey step4_email = ValueKey("step4_email");
  static const ValueKey step4_password = ValueKey("step4_password");
  static const ValueKey step5 = ValueKey("step5");
  static const ValueKey step6 = ValueKey("step6");
  static const ValueKey step7 = ValueKey("step7");
  static const ValueKey step8 = ValueKey("step8");
  static const ValueKey step8_star = ValueKey("step8_star");
  static const ValueKey step8_sort = ValueKey("step8_sort");
  static const ValueKey step9 = ValueKey("step9");
  static const ValueKey step10 = ValueKey("step10");
  static const ValueKey step13 = ValueKey("step13");
  static const ValueKey step14_up = ValueKey("step14_up");
  static const ValueKey step14_add = ValueKey("step14_add");
  static const ValueKey step15 = ValueKey("step15");
  static const ValueKey step16 = ValueKey("step16");
  static const ValueKey step17 = ValueKey("step17");
  static const ValueKey step18 = ValueKey("step18");
  static const ValueKey step19 = ValueKey("step19");
  static const ValueKey step20 = ValueKey("step20");
  static const ValueKey step21 = ValueKey("step21");
  static const ValueKey step22_star = ValueKey("step22_star");
  static const ValueKey step22_review = ValueKey("step22_review");
  static const ValueKey step22_add = ValueKey("step22_add");
  static const ValueKey step24 = ValueKey("step24");
  static const ValueKey step25 = ValueKey("step25");
  static const ValueKey step26_address = ValueKey("step26_address");
  static const ValueKey step26_add = ValueKey("step26_add");
  static const ValueKey step27 = ValueKey("step27");
  static const ValueKey step28 = ValueKey("step28");
}