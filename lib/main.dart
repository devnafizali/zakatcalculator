// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

import 'calculator_screen.dart';
import 'contact_screen.dart';
import 'faq_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List screenList = [
    const HomeScreen(),
    CalculatorScreen(),
    const FaqScreen(),
    const ContactScreen()
  ];
  int _screenIndex = 1;
  void changeScreen(value) {
    setState(() {
      _screenIndex = value;
      print(_screenIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent[400],
        ),
        body: screenList[_screenIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme: IconThemeData(color: Colors.orangeAccent[400]),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: _screenIndex,
          backgroundColor: Colors.grey[200],
          selectedItemColor: Colors.orangeAccent[400],
          onTap: (value) => changeScreen(value),
          items: const [
            BottomNavigationBarItem(
                label: 'Menu',
                icon: Icon(
                  Icons.home_outlined,
                )),
            BottomNavigationBarItem(
                label: 'Calculator',
                icon: Icon(
                  Icons.calculate_outlined,
                )),
            BottomNavigationBarItem(
                label: 'FAQ\'s',
                icon: Icon(
                  Icons.format_quote,
                )),
            BottomNavigationBarItem(
                label: 'Contact us',
                icon: Icon(
                  Icons.contact_phone_outlined,
                ))
          ],
        ),
      ),
    );
  }
}
