import 'dart:async';

import 'package:RoomMeMobile/http/client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _link = "https://room-me-app.herokuapp.com/house/all";

  HomeBloc() : super(InitialState(body: []));

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is InitialEvent){
      List<Map<String, dynamic>> houses = await _getHouses();
      yield InitialState(body: houses);
      // yield InitialState(body: [{'foto': 'https://q4g9y5a8.rocketcdn.me/wp-content/uploads/2020/02/home-banner-2020-02-min.jpg', 'title': 'Casa de Maki'}]);
    }
  }

  Future<List<Map<String, dynamic>>> _getHouses() async {
    try {
      HttpClient client = HttpClient.getClient();
      dynamic response = await client.get(_link, null);
      List<Map<String, dynamic>> houses = List.from(response);
      return houses;
    } catch (error) {
      print('error al obtener casas:\n' + error.toString());
      return ([]);
    }
  }
}
