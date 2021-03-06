import 'dart:async';

import 'package:RoomMeMobile/http/client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _link = "https://room-me-app.herokuapp.com/house/all";
  HttpClient client;

  HomeBloc() : super(InitialState(body: [])) {
    client = HttpClient.getClient();
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is InitialEvent) {
      List<Map<String, dynamic>> houses = await _getHouses();
      yield InitialState(body: houses);
    }
  }

  Future<List<Map<String, dynamic>>> _getHouses() async {
    try {
      dynamic response = await client.get(_link, null);
      List<Map<String, dynamic>> houses = List.from(response);
      return houses;
    } catch (error) {
      print('error al obtener casas:\n' + error.toString());
      return ([]);
    }
  }
}
