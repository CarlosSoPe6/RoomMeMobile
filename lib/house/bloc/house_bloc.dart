import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:RoomMeMobile/http/client.dart';
import 'package:RoomMeMobile/models/house.dart';
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
        print(response);
        House house = House.fromJson(response);
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
      } catch (e) {
        print(e);
        yield HouseErrorState(error: "Fallo en la carga de archivo");
      }
    } else {
      yield HouseErrorState(error: "No event map");
    }
  }
}
