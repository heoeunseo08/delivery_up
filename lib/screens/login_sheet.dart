import 'dart:developer';
import 'package:delivery_up/controller/auth_controller.dart';
import 'package:delivery_up/utils/info.dart';
import 'package:delivery_up/utils/widget.dart';
import 'package:flutter/material.dart';

class LoginSheet extends StatefulWidget {
  const LoginSheet({super.key});

  @override
  State<LoginSheet> createState() => _LoginSheetState();
}

class _LoginSheetState extends State<LoginSheet> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
          header(),
          SizedBox(height: 24),
          titleText("로그인"),
          SizedBox(height: 24),
          fields(),
          SizedBox(height: 24),
          buttons(
            context: context,
            text: "로그인",
            onTap: () async {
              final authController = AuthController();
              final error = authController.error;

              if (error != null) {
                log(error);
                return;
              }

              final success = await authController.login(
                emailText: emailController.text.trim(),
                passwordText: passwordController.text.trim(),
              );

              if (success) {
                Navigator.pop(context);
              }

              Navigator.pop(context);
            },
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget fields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "이메일",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            border: border,
            disabledBorder: border,
            focusedBorder: border,
            enabledBorder: border,
            hint: hintTexts("user@mad.co.kr"),
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          ),
        ),
        SizedBox(height: 24),
        Text(
          "비밀번호",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            border: border,
            disabledBorder: border,
            focusedBorder: border,
            enabledBorder: border,
            hint: hintTexts("* * * * * * * *"),
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          ),
        ),
      ],
    );
  }
}

void showLogin(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => LoginSheet(),
  );
}
