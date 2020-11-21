import 'package:RoomMeMobile/chat/chat.dart';
import 'package:RoomMeMobile/house/create_house.dart';
import 'package:RoomMeMobile/house/details_house.dart';
import 'package:RoomMeMobile/login/login_page.dart';
import 'package:RoomMeMobile/register/register.dart';
import 'package:RoomMeMobile/usuario/user.dart';
import 'package:flutter/material.dart';

import 'homepage/home.dart';

Route<dynamic> buildRouter(RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => LoginPage(),
        fullscreenDialog: true,
      );
    case '/register':
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => Register(),
        fullscreenDialog: true,
      );
    case '/home':
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => Home(houses: settings.arguments),
        fullscreenDialog: true,
      );
    case '/user':
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => UserPage(),
        fullscreenDialog: true,
      );
    case '/house/detail':
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => DetailsHouse(
          hid: settings.arguments,
        ),
        fullscreenDialog: true,
      );
    case '/house/new':
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => CreateHouse(
          house: null,
        ),
        fullscreenDialog: true,
      );
    case '/house/edit':
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => CreateHouse(
          house: settings.arguments,
        ),
      );
    case '/chat':
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => Chat(),
        fullscreenDialog: true,
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}
