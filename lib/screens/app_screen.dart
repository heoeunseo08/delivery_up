import 'package:delivery_up/screens/home_screen.dart';
import 'package:delivery_up/screens/log_screen.dart';
import 'package:delivery_up/screens/profile_screen.dart';
import 'package:delivery_up/screens/search_screen.dart';
import 'package:delivery_up/utils/info.dart';
import 'package:flutter/material.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int selectIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    LogScreen(),
    ProfileScreen(),
  ];

  List<Icon> icons = [
    Icon(Icons.home_outlined, key: Key(Keys.tab_home)),
    Icon(Icons.search),
    Icon(Icons.article_outlined),
    Icon(Icons.person_outline, key: Key(Keys.tab_profile)),
  ];

  List<String> labels = ["홈", "검색", "주문내역", "프로필"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainColor,
        unselectedItemColor: subColor,
        backgroundColor: Colors.white,
        iconSize: 35,
        selectedLabelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),
        unselectedLabelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),
        onTap: (value) => setState(() => selectIndex= value),
        items: List.generate(
          4,
          (index) => BottomNavigationBarItem(
            icon: icons[index],
            label: labels[index],
          ),
        ),
      ),
    );
  }
}
