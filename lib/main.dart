import 'package:delivery_up_test4/screen/app_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
        ),
      ),
      home: const AppScreen(initIndex: 0),
    );
  }
}
