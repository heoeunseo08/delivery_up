import 'package:delivery_up/utils/info.dart';
import 'package:flutter/material.dart';

Widget titleText(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontSize: 18,
    ),
  );
}

Widget hintTexts(String text) {
  return Text(text, style: hintTextSt);
}

Widget header() {
  return Center(
    child: Container(
      decoration: BoxDecoration(
        color: subColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(99),
      ),
      height: 5,
      width: 50,
    ),
  );
}

Widget buttons({
  required BuildContext context,
  required String text,
  required GestureTapCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      width: MediaQuery.widthOf(context),
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
