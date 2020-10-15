import 'package:RoomMeMobile/login.dart';
import 'package:RoomMeMobile/register.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xFF8FD8D2),
          primaryTextTheme: TextTheme(
            headline6: TextStyle(color: Colors.white)
          ),
          buttonTheme: ButtonThemeData(buttonColor: Color(0xFFFEDCD2))
        ),
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/home': (context) => Home()
      }
    );
  }
}
