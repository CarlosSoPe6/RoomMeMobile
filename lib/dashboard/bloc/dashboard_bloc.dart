import 'dart:async';

import 'package:RoomMeMobile/http/client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final _getHouseslink = "https://room-me-app.herokuapp.com/house/all";
  final _postTaskslink = "https://room-me-app.herokuapp.com/api/tasks";

  DashboardBloc() : super(InitialState());

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is InitialEvent){
      // List<Map<String, dynamic>> houses = await _getHouses();
      yield InitialState();
    }
    else if(event is CreateTaskEvent) {
      await _createTask(event.description, event.hid);
      List<Map<String, dynamic>> houses = await _getHouses();
      yield(TaskCreatedState(houses: houses));
    }
  }

  Future<List<Map<String, dynamic>>> _getHouses() async {
    try {
      HttpClient client = HttpClient.getClient();
      dynamic response = await client.get(_getHouseslink, null);
      List<Map<String, dynamic>> houses = List.from(response);
      return houses;
    } catch (error) {
      print('error al obtener casas:\n' + error.toString());
      return ([]);
    }
  }


  Future<Map<String, dynamic>> _createTask(String description, int hid) async {
    try {
      HttpClient client = HttpClient.getClient();
      Map<String, dynamic> body = {
        'house': hid,
        'description': description,
      };
      dynamic response = await client.post(_postTaskslink, body);
      return response;
    } catch (error) {
      print('Error al crear tarea:\n' + error.toString());
      return ({'fronError': 'true'});
    }
  }
}
