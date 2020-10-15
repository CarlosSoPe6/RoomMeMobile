import 'package:RoomMeMobile/house/create_house.dart';
import 'package:RoomMeMobile/house/details_house.dart';
import 'package:RoomMeMobile/login.dart';
import 'package:RoomMeMobile/principal/principal.dart';
import 'package:RoomMeMobile/register.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xFF8FD8D2),
            primaryTextTheme:
                TextTheme(headline6: TextStyle(color: Colors.white)),
            buttonTheme: ButtonThemeData(buttonColor: Color(0xFFFEDCD2))),
        home: Login(),
        routes: {
          '/register': (context) => Register(),
          '/principal': (context) => Principal(),
          '/house/detail': (context) => DetailsHouse(),
          '/house/new': (context) => CreateHouse(),
        });
  }
}
