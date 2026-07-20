import 'package:delivery_up_test4/utils/info.dart';
import 'package:flutter/material.dart';

Widget loading() {
  return Center(child: CircularProgressIndicator());
}

Widget headerBar() {
  return Center(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        color: subColor.withOpacity(0.3),
      ),
      width: 60,
      height: 6,
    ),
  );
}

Widget buttons({ required BuildContext context, required String text, required GestureTapCallback onTap, Key? key }){
  return
    GestureDetector(
      onTap: onTap,
      child: Container(
        key: key,
        alignment: AlignmentGeometry.center,
        width: MediaQuery.widthOf(context),
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
        text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
}
