import 'package:delivery_up/utils/info.dart';
import 'package:flutter/material.dart';

class LoginSheet extends StatefulWidget {
  const LoginSheet({super.key});

  @override
  State<LoginSheet> createState() => _LoginSheetState();
}

class _LoginSheetState extends State<LoginSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.widthOf(context)),
          header()
        ],
      ),
    );
  }

  Widget header() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: subColor,
          borderRadius: BorderRadius.circular(99),
        ),
        height: 5,
        width: 50
      ),
    );
  }
}

void showLogin(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => LoginSheet(),
  );
}
