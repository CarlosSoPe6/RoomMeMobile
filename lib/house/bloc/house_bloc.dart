import 'dart:async';

import 'package:RoomMeMobile/http/client.dart';
import 'package:RoomMeMobile/models/house.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'house_event.dart';
part 'house_state.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {
  final String _url = "https://room-me-app.herokuapp.com/house/";
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
        var response = await client.get(uri.toString(), null);
        House house = House.fromJson(response);
        yield HouseFetchedState(house: house);
      } catch (e) {
        print(e);
        yield HouseErrorState(error: e.toString());
      }
    } else {
      yield HouseErrorState(error: "No event map");
    }
  }
}
