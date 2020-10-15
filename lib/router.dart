import 'package:RoomMeMobile/house/create_house.dart';
import 'package:RoomMeMobile/house/details_house.dart';
import 'package:RoomMeMobile/login.dart';
import 'package:RoomMeMobile/register.dart';
import 'package:RoomMeMobile/usuario/user.dart';
import 'package:flutter/material.dart';

import 'home.dart';

Route<dynamic> buildRouter(RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => Login(),
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
        builder: (BuildContext context) => Home(),
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
        builder: (BuildContext context) => DetailsHouse(),
        fullscreenDialog: true,
      );
    case '/house/new':
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => CreateHouse(),
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
