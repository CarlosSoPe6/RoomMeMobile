import 'package:RoomMeMobile/router.dart';
import 'package:flutter/material.dart';

import 'login/login_page.dart';
 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoomMe',
      theme: ThemeData(
          primaryColor: Color(0xFF8FD8D2),
          primaryTextTheme:
              TextTheme(headline6: TextStyle(color: Colors.white)),
          buttonTheme: ButtonThemeData(buttonColor: Color(0xFFFEDCD2))),
      initialRoute: '/home',
      onGenerateRoute: buildRouter,
    );
  }
}
