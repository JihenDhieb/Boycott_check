import 'package:flutter/material.dart';
import 'package:flutter_app/pages/Home_Page.dart';
import 'package:flutter_app/pages/QrCode-page.dart';
import 'package:flutter_app/pages/WelcomePage.dart';
import 'package:flutter_app/pages/boycotted_page.dart';
import 'package:flutter_app/pages/notBoycotted_page.dart';
import 'package:flutter_app/pages/Last_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: 'Welcome', routes: {
      'Welcome': (context) => Page1(),
      'boycottedPage': (context) => boycotted(),
      'notBoycottedPage': (context) => notboycotted(),
      'LastPage': (context) => Page4(),
      'BarCodeScanner': (context) => BarCodeScanner(),
      'HomePage': (context) => HomePage(),
    });
  }
}
