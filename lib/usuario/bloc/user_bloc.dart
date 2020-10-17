import 'dart:async';
import 'dart:io';
import 'dart:convert' as convert;

import 'package:RoomMeMobile/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final String _url = "https://room-me-app.herokuapp.com/user/";

  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserFetchEvent) {
      try {
        int uid = event.uid;
        String uri = "$_url$uid";
        var response = await http.get(uri.toString());
        print(response.body);
        var json = convert.jsonDecode(response.body);
        User user = User.fromJson(json);
        File profileImage = File(user.photo);
        yield UserFetchedState(user: user, profileImage: profileImage);
      } catch (e) {
        print(e);
        yield UserErrorState(error: e.toString());
      }
    }
    if (event is UserImageUpdateEvent) {
      yield UserImageUpdatedState(profileImage: event.profileImage);
    } else {
      yield UserErrorState(error: "Error");
    }
  }
}
