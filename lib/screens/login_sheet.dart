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
            key: Key(Keys.try_login),
            context: context,
            text: "로그인",
            onTap: () async {
              final authController = AuthController();

              if (authController.error != null) {
                log("${authController.error}");
                return;
              }
              print("object");

              final success = await authController.login(
                emailText: emailController.text.trim(),
                passwordText: passwordController.text.trim(),
              );

              if (success) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
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
          key: Key(Keys.login_email),
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
          key: Key(Keys.login_password),
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

Future<void> showLogin(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    builder: (context) => LoginSheet(),
  );
}
