import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';


part 'custom_event.dart';
part 'custom_state.dart';

class MainBloc extends Bloc<CustomEvent, CustomState> {
  final _link = "https://room-me-app.herokuapp.com/api/register";

  MainBloc() : super(InitialState());

  @override
  Stream<CustomState> mapEventToState(
    CustomEvent event,
  ) async* {
    if (event is InitialEvent) {
      yield InitialState();
    } else if (event is RegisterEvent) {
      String response = await _register(jsonEncode({
        'name': event.name,
        'lastName': event.lastname,
        'email': event.email,
        'password': event.password,
      }));
      if (response == '0'){
        yield RegisteredState();
      }
      else
        yield ErrorState(error: response);

    }
  }

  Future<String> _register(body) async {
    try {
      Response response = await post(_link, headers:{"Content-type": "application/json"}, body: body);
      if(response.statusCode == 200)
        return '0';
      else
        return jsonDecode(response.body)['error'];
    } catch (error) {
      print(error.toString());
      return (error.toString());
    }
  }
}
