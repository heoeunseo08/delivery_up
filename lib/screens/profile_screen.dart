import 'dart:developer';

import 'package:delivery_up/controller/auth_controller.dart';
import 'package:delivery_up/controller/method_controller.dart';
import 'package:delivery_up/controller/profile_controller.dart';
import 'package:delivery_up/screens/address_screen.dart';
import 'package:delivery_up/screens/log_screen.dart';
import 'package:delivery_up/screens/login_sheet.dart';
import 'package:delivery_up/utils/info.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Widget profileImage() {
  return GestureDetector(
    onTap: () => log("프로필 이미지 선택"),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/default_profile.png",
          height: 80,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: mainColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 15),
          ),
        ),
      ],
    ),
  );
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = ProfileController();
  AuthController authController = AuthController();

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
          : profileController.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.widthOf(context)),
                infoWidget(),
                SizedBox(height: 20),
                logWidget(),
                SizedBox(height: 20),
                buttons(),
                SizedBox(height: 20),
                logoutText(),
              ],
            ),
    );
  }

  Widget infoWidget() {
    return Column(
      children: [
        profileImage(),
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
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: subColor.withOpacity(0.4), width: 1.5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          logItem("${profileController.profileModel.orderCount}", "주문"),
          Container(color: subColor.withOpacity(0.4), height: 90, width: 2),
          logItem("${profileController.profileModel.favoriteCount}", "찜"),
          Container(color: subColor.withOpacity(0.4), height: 90, width: 2),
          logItem("${profileController.profileModel.reviewCount}", "리뷰"),
        ],
      ),
    );
  }

  Widget logItem(String title, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget buttons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          buttonItem(
            icons: Icons.location_on_outlined,
            text: "배송지 관리",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressScreen()),
              );
            },
          ),
          buttonItem(
            icons: Icons.article_outlined,
            text: "주문 내역",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LogScreen(),
                ),
              );
            },
          ),
          buttonItem(
            icons: Icons.headset_mic_outlined,
            text: "고객 센터",
            onTap: () async {
              await launchUrl(Uri.parse("http://support.deliveryup.com/"));
            },
          ),
          buttonItem(
            icons: Icons.info_outline,
            text: "앱 정보",
            onTap: () => showMessage("준비 중입니다. "),
          ),
        ],
      ),
    );
  }

  Widget buttonItem({
    required IconData icons,
    required String text,
    required GestureTapCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.5, color: subColor.withOpacity(0.3)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icons,
                  size: 30,
                  color: subColor,
                ),
                SizedBox(width: 12),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 25,
              color: subColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget logoutText() {
    return GestureDetector(
      onTap: () => logoutPopup(),
      child: Text(
        "로그아웃",
        style: TextStyle(
          color: subColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void logoutPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        alignment: Alignment.center,
        title: Text(
          "로그아웃",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        content: Text(
          "정말 로그아웃 하시겠어요?",
          style: TextStyle(
            color: subColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                  decoration: BoxDecoration(
                    color: subColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "취소",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () async {
                  await authController.logout();
                  showMessage("로그아웃 되었습니다.");
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "확인",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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
