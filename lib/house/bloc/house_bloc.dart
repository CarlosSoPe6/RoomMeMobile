import 'dart:async';
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
      "https://room-me-app.herokuapp.com/image/upload/house";
  HttpClient client;

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
      final profileImage = event.file;
      try {
        await client.uploadImage(_uploadUrl, profileImage);
      } catch (e) {
        print(e);
        yield HouseErrorState(error: "Fallo en la carga de archivo");
      }
    } else if (event is HouseCreateEvent) {
      yield HouseCreateState();
    } else if (event is HouseSaveEvent) {
      var isNew = event.isNew;
      var processHouse = event.house;
      try {
        if (isNew) {
          var body = processHouse.toJson();
          var response = await client.post(_url, body);
          print(response);
        } else {}
      } catch (e) {
        print(e);
      }
    } else {
      yield HouseErrorState(error: "No event map");
    }
  }
}
