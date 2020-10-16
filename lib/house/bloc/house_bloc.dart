import 'dart:async';
import 'dart:convert' as convert;

import 'package:RoomMeMobile/models/house.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'house_event.dart';
part 'house_state.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {
  final String _url = "https://room-me-app.herokuapp.com/house/";

  HouseBloc() : super(HouseInitial());

  @override
  Stream<HouseState> mapEventToState(
    HouseEvent event,
  ) async* {
    if (event is HouseFetchEvent) {
      try {
        int hid = event.hid;
        String uri = "$_url$hid";
        // var response = await http.get(uri.toString());
        var json = convert.jsonDecode(
            '{"services":[1,2,3],"_id":"5ebc2d3a9b898e001724ec12","title":"La casa del senpai","type":"Departamento","description":"Aqui vivimos los chidos","ownerId":10000,"addressLine":"por ahi","zipCode":"12378","city":"Guadalajara","state":"Jalisco","country":"Mexico","cost":5000,"roommatesLimit":4,"roommatesCount":0,"playlistURL":null,"foto":"https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.ytimg.com%2Fvi%2FtP1vjY15L58%2Fmaxresdefault.jpg&f=1&nofb=1","hid":27,"__v":0}');
        House house = House.fromJson(json);
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
