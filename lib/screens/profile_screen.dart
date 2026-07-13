import 'package:delivery_up/controller/profile_controller.dart';
import 'package:delivery_up/screens/login_sheet.dart';
import 'package:delivery_up/utils/info.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = ProfileController();

  @override
  void initState() {
    super.initState();
    if (isLogin) load();
  }

  Future<void> load() async {
    await profileController.load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "프로필",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: !isLogin
          ? noLogin()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.widthOf(context)),
                infoWidget(),
              ],
            ),
    );
  }

  Widget infoWidget() {
    return Column(
      children: [
        Image.asset(
          "assets/images/default_profile.png",
          height: 80,
        ),
        SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name.value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            SizedBox(width: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: subColor.withOpacity(0.2),
              ),
              child: Text(
                grade.value,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Text(
          email.value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: subColor,
          ),
        ),
      ],
    );
  }

  Widget logWidget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: subColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [],
      ),
    );
  }



  Widget noLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: MediaQuery.widthOf(context)),
        Image.asset("assets/images/default_profile.png", width: 80),
        SizedBox(height: 15),
        Text(
          "로그인이 필요합니다.",
          style: TextStyle(
            color: subColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 2),
        Text(
          "로그인 후 배달 서비스를 이용할 수 있어요.",
          style: TextStyle(
            color: subColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 15),
        GestureDetector(
          onTap: () async {
            await showLogin(context);
            await load();
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 70),
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "로그인",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
