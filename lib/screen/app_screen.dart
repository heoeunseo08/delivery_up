import 'package:delivery_up_test4/screen/home_screen.dart';
import 'package:delivery_up_test4/screen/log_screen.dart';
import 'package:delivery_up_test4/screen/profile_screen.dart';
import 'package:delivery_up_test4/screen/search_screen.dart';
import 'package:delivery_up_test4/utils/info.dart';
import 'package:flutter/material.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key, required this.initIndex});

  final int initIndex;

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initIndex;
  }


  List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    LogScreen(),
    ProfileScreen(),
  ];

  List<String> labels = [
    "홈",
    "검색",
    "주문내역",
    "프로필",
  ];

  List<Icon> icons = [
    Icon(Icons.home_outlined,key: Keys.step5),
    Icon(Icons.search),
    Icon(Icons.article_outlined),
    Icon(Icons.person_outline,key: Keys.step2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedLabelStyle: TextStyle(color: mainColor),
        unselectedLabelStyle: TextStyle(color: subColor),
        selectedItemColor: mainColor,
        unselectedItemColor: subColor,
        items: List.generate(
          4,
          (index) => BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: icons[index],
            label: labels[index],
          ),
        ),
      ),
    );
  }
}
