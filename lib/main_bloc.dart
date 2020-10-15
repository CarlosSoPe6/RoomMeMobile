import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'models/user.dart';
import 'package:http/http.dart';


part 'custom_event.dart';
part 'custom_state.dart';

class MainBloc extends Bloc<CustomEvent, CustomState> {
  final _link = "http://192.168.100.5:3000/api/register";
  List<User> _userList;

  MainBloc() : super(InitialState());

  @override
  Stream<CustomState> mapEventToState(
    CustomEvent event,
  ) async* {
    if (event is InitialEvent) {
      yield InitialState();
    } else if (event is RegisterEvent) {
      await _getAllUsers(jsonEncode({
        'name': event.name,
        'lastName': event.lastname,
        'email': event.email,
        'password': event.password,
      }));
      yield RegisteredState();
      // if (_userList.length > 0)
      //   yield ShowUsersState(usersList: _userList);
      // else
      //   yield ErrorState(error: "No hay elementos por mostrar");
    }
  }

  Future _getAllUsers(body) async {
    try {
      Response response = await post(_link, headers:{"Content-type": "application/json"}, body: body);
      print(response.body);
      // if (response.statusCode == 200) {
      //   _userList = List();
      //   List<dynamic> data = jsonDecode(response.body);
      //   _userList = data.map((element) => User.fromJson(element)).toList();
      // }
    } catch (error) {
      print(error.toString());
      // _userList = List();
    }
  }
}
