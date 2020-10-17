import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _link = "https://room-me-app.herokuapp.com/house";

  HomeBloc() : super(InitialState(body: ''));

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is InitialEvent) {
      // String response = await _getHouses();
      yield InitialState(body: {'foto': 'https://q4g9y5a8.rocketcdn.me/wp-content/uploads/2020/02/home-banner-2020-02-min.jpg', 'title': 'Casa de Maki'});
    }
  //     else
  //       yield ErrorState(error: response);
  //   }
  }

  Future<String> _getHouses() async {
    try {
      Response response = await get(_link, headers:{"Content-type": "application/json"});
      if(response.statusCode == 200)
        return response.body;
      else
        return jsonDecode(response.body)['error'];
    } catch (error) {
      print(error.toString());
      return (error.toString());
    }
  }
}
