import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:RoomMeMobile/http/client.dart';
import 'package:RoomMeMobile/models/house.dart';
import 'package:RoomMeMobile/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'house_event.dart';
part 'house_state.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {
  final String _url = "https://room-me-app.herokuapp.com/house/";
  final String _uploadUrl =
      "https://room-me-app.herokuapp.com/image/upload/house/";
  HttpClient client;
  File imageToUpload = null;
  List<User> _usuarios = List();
  List<User> get getUsers => _usuarios;

  HouseBloc() : super(HouseInitial()) {
    client = HttpClient.getClient();
  }

  @override
  Stream<HouseState> mapEventToState(
    HouseEvent event,
  ) async* {
    if (event is HouseFetchEvent) {
      try {
        int hid = event.hid;
        String uri = "$_url$hid";
        print(uri);
        var response = (await client.get(uri.toString(), null));
        House house = House.fromJson(response);
        await _getAllUsers();
        yield HouseFetchedState(house: house);
      } catch (e) {
        print(e);
        yield HouseErrorState(error: e.toString());
      }
    } else if (event is HouseUpdateFotoEvent) {
      imageToUpload = event.file;
    } else if (event is HouseCreateEvent) {
      yield HouseCreateState();
    } else if (event is HouseSaveEvent) {
      var isNew = event.isNew;
      var processHouse = event.house;
      int houseId = 0;
      try {
        if (isNew) {
          var body = processHouse.toJson();
          var response = await client.post(_url, body);
          var json = jsonDecode(response);
          houseId = json['hid'];
          print(response);
        } else {
          houseId = event.house.hid;
          var body = processHouse.toJson();
          await client.put(_url, body);
        }
        if (imageToUpload != null) {
          await client.uploadImage("$_uploadUrl$houseId", imageToUpload);
        }
        await _updateUsersHouses(processHouse.members, processHouse.hid);
      } catch (e) {
        print(e);
        yield HouseErrorState(error: "Fallo en la carga de archivo");
      }
      yield HomeActionSuccess();
    } else {
      yield HouseErrorState(error: "No event map");
    }
  }

  _getAllUsers() async {
    String uriUsers = "https://room-me-app.herokuapp.com/user/";
    List<dynamic> userResponse = await client.get(uriUsers, null);
    userResponse.forEach((element) {
      _usuarios.add(User.fromJson(element));
    });
  }

  _updateUsersHouses(List<dynamic> updatedMembers, int houseId) async {
    String uriUserHouses = "https://room-me-app.herokuapp.com/user/houses";
    List<User> previousUsers = _usuarios.where((user) => user.houses.contains(houseId)).toList();
    List<int> previousUsersId = previousUsers.map((e) => e.uid).toList();
    print("Usuarios Anteriores: $previousUsersId");
    print("Usuarios Nuevos: $updatedMembers");

    print("Añadiendo usuarios");
    for(var i = 0; i < updatedMembers.length; i++) {
      if(!previousUsersId.contains(updatedMembers[i])) {
        User newResident = _usuarios.firstWhere((element) => element.uid == updatedMembers[i]);
        newResident.houses.add(houseId);
        var response = await client.put(uriUserHouses, {
          'uid' : updatedMembers[i],
          'houses' : newResident.houses
        });
        print("La casa $houseId se le añadio a ${newResident.uid}");
        print(response);
      }
    }
    
    print("Eliminando usuarios");
    for(var j = 0; j < previousUsersId.length; j++) {
      if(!updatedMembers.contains(previousUsersId[j])) {
        User newResident = _usuarios.firstWhere((element) => element.uid == previousUsersId[j]);
        newResident.houses.remove(houseId);
        var response = await client.put(uriUserHouses, {
          'uid' : previousUsersId[j],
          'houses' : newResident.houses
        });
        print("La casa $houseId se elimino de ${newResident.uid}");
        print(response);
      }
    }

  }
}
