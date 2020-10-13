import 'package:flutter/material.dart';

import 'login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Me',
      theme: ThemeData(
        primaryColor: Color(0xFF8FD8D2)
      ),
      home: LoginPage(),
    );
  }
}