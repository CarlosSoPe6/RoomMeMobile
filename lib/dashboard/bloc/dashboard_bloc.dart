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

  int x = 0;

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
      yield(TaskChengedState(houses: houses, action: 0));
    }
    else if(event is DeleteTaskEvent) {
      await _deleteTask(event.id);
      List<Map<String, dynamic>> houses = await _getHouses();
      yield(TaskChengedState(houses: houses, action: 1));
    }
    else if(event is EditTaskEvent) {
      x = (x+1)%2;
      await _editTask(event.task);
      List<Map<String, dynamic>> houses = await _getHouses();
      yield(TaskChengedState(houses: houses, action: 2 + x));
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


  Future<void> _createTask(String description, int hid) async {
    try {
      HttpClient client = HttpClient.getClient();
      Map<String, dynamic> body = {
        'house': hid,
        'description': description,
      };
      await client.post(_postTaskslink, body);
    } catch (error) {
      print('Error al crear tarea:\n' + error.toString());
    }
  }

  Future<void> _deleteTask(int id) async {
    try {
      HttpClient client = HttpClient.getClient();
      String url = _postTaskslink + '/' + id.toString();
      await client.delete(url, null);
    } catch (error) {
      print('Error al eliminar tarea:\n' + error.toString());
    }
  }
  
  Future<void> _editTask(dynamic task) async {
    try {
      HttpClient client = HttpClient.getClient();
      Map<String, dynamic> body = {
        "taskId": task['tid'],
        "author": task['authorId'],
        "house": task['houseId'],
        "description": task['description'],
        "date": task['creationDate'],
        "complete": task['complete']
      };
      await client.put(_postTaskslink, body);
    } catch (error) {
      print('Error al editar tarea :\n' + error.toString());
    }
  }
}
