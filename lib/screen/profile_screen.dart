import 'dart:io';

import 'package:delivery_up_test4/controller/auth_controller.dart';
import 'package:delivery_up_test4/controller/image_controller.dart';
import 'package:delivery_up_test4/controller/method_controller.dart';
import 'package:delivery_up_test4/controller/profile_controller.dart';
import 'package:delivery_up_test4/screen/address_screen.dart';
import 'package:delivery_up_test4/screen/log_screen.dart';
import 'package:delivery_up_test4/utils/info.dart';
import 'package:delivery_up_test4/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = ProfileController();
  AuthController authController = AuthController();
  ImageController imageController = ImageController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (isLogin) load();
    loadImage();
  }

  Future<void> load() async {
    await profileController.load();
    setState(() {});
  }

  Future<void> loadImage() async {
    await imageController.profileLoad();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: profileController.isLoading
          ? loading()
          : !isLogin
          ? noLogin()
          : Column(
              children: [
                SizedBox(height: 80),
                profileWidget(),
                logBox(),
                moreButtons(),
                SizedBox(height: 30),
                GestureDetector(
                  key: Keys.step27,
                  onTap: () => checkLogout(),
                  child: Text("로그아웃"),
                ),
              ],
            ),
    );
  }

  void checkLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text("로그아웃"),
        content: Text("로그아웃 하시겠습니까?"),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text("취소"),
          ),
          GestureDetector(
            key: Keys.step28,
            onTap: () async {
              await authController.logout();
              setState(() {});
              showMessage("로그아웃 되었습니다");
              Navigator.pop(context);
            },
            child: Text("확인"),
          ),
        ],
      ),
    );
  }

  Widget profileWidget() {
    return Column(
      children: [
        SizedBox(width: MediaQuery.widthOf(context)),
        GestureDetector(
          onTap: () => pickImage(),
          child: ClipOval(
            child: imageController.profilePath != null
                ? Image.file(
                    File(imageController.profilePath!),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/003. images/default_profile.png",
                    width: 80,
                  ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name.value,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: subColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(
                grade.value,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: subColor,
                ),
              ),
            ),
          ],
        ),
        Text(
          email.value,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: subColor,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void pickImage() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 20,
          children: [
            SizedBox(width: MediaQuery.widthOf(context)),
            TextButton(
              onPressed: () async {
                await imageController.profilePick(ImageSource.camera);
                loadImage();
                setState(() {});
              },
              child: Text("카메라로 촬영"),
            ),
            TextButton(
              onPressed: () async {
                await imageController.profilePick(ImageSource.gallery);
                loadImage();
                setState(() {});
              },
              child: Text("갤러리에서 선택"),
            ),
            if (imageController.profilePath != null)
              TextButton(
                onPressed: () async {
                  await imageController.profileRemove();
                  setState(() {});
                },
                child: Text("프로필 사진 삭제"),
              ),
          ],
        ),
      ),
    );
  }

  Widget logBox() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: subColor,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
            child: Column(
              children: [
                Text(
                  "${profileController.model!.orderCount}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "주문",
                  style: TextStyle(
                    color: subColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 90, width: 1.5, color: subColor),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            child: Column(
              children: [
                Text(
                  "${profileController.model!.favoriteCount}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "찜",
                  style: TextStyle(
                    color: subColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 90, width: 1.5, color: subColor),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            child: Column(
              children: [
                Text(
                  "${profileController.model!.reviewCount}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "리뷰",
                  style: TextStyle(
                    color: subColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget moreButtons() {
    return Column(
      spacing: 12,
      children: [
        GestureDetector(
          key: Keys.step24,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddressScreen(),
              ),
            );
          },
          child: Text("배송지 관리"),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LogScreen(),
              ),
            );
          },
          child: Text("주문 내역"),
        ),
        GestureDetector(
          onTap: () async {
            await launchUrl(Uri.parse("http://support.deliveryup.com"));
          },
          child: Text("고객센터"),
        ),
        GestureDetector(
          onTap: () {
            showMessage("아직 준비중입니다.");
          },
          child: Text("앱 정보"),
        ),
      ],
    );
  }

  Future<void> loginSheet() async {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerBar(),
            Text(
              "로그인",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
            ),
            SizedBox(height: 20),
            Text(
              "이메일",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            SizedBox(height: 4),
            TextFormField(
              key: Keys.step4_email,
              controller: email_controller,
              decoration: InputDecoration(
                border: border,
                disabledBorder: border,
                enabledBorder: border,
                focusedBorder: border,
                hint: Text(
                  "user@mad.co.kr",
                  style: TextStyle(color: subColor),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "비밀번호",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            SizedBox(height: 4),
            TextFormField(
              key: Keys.step4_password,
              controller: password_controller,
              decoration: InputDecoration(
                border: border,
                disabledBorder: border,
                enabledBorder: border,
                focusedBorder: border,
                hint: Text(
                  "* * * * * * * *",
                  style: TextStyle(color: subColor),
                ),
              ),
            ),
            SizedBox(height: 24),
            GestureDetector(
              key: Keys.step4,
              onTap: () async {
                await authController.login(
                  emailText: email_controller.text,
                  passwordText: password_controller.text,
                );
                await load();
                Navigator.pop(context);
              },
              child: Container(
                alignment: AlignmentGeometry.center,
                width: MediaQuery.widthOf(context),
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "로그인",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: MediaQuery.widthOf(context)),
        Image.asset("assets/003. images/default_profile.png", width: 70),
        SizedBox(height: 20),
        Text("로그인이 필요합니다."),
        SizedBox(height: 4),
        Text("로그인 후 배달 서비스를 이용할 수 있어요"),
        SizedBox(height: 20),
        GestureDetector(
          key: Keys.step3,
          onTap: () async {
            await loginSheet();
            load();
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 14),
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "로그인",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
