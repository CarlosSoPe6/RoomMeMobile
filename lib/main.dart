import 'package:RoomMeMobile/router.dart';
import 'package:flutter/material.dart';


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
      initialRoute: '/login',
      // routes: {
      //   '/login': (context) => LoginPage(),
      //   '/register': (context) => Register(),
      //   '/home': (context) => Home(),
      //   '/user': (context) => UserPage(),
      //   '/house/detail': (context) => DetailsHouse(),
      //   '/house/new': (context) => CreateHouse(),
      //   '/chat': (context) => Chat()
      // },
      onGenerateRoute: buildRouter,
    );
  }
}
