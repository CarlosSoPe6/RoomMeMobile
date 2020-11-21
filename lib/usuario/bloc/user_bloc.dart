import 'dart:async';
import 'dart:io';

import 'package:RoomMeMobile/http/client.dart';
import 'package:RoomMeMobile/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final String _url = "https://room-me-app.herokuapp.com/user/";
  final String _uploadUrl =
      "https://room-me-app.herokuapp.com/image/upload/user";
  HttpClient client;

  UserBloc() : super(UserInitial()) {
    client = HttpClient.getClient();
  }

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserFetchEvent) {
      try {
        int uid = event.uid;
        String uri = "$_url$uid";
        var response = await client.get(uri.toString(), null);
        User user = User.fromJson(response);
        yield UserFetchedState(user: user, profileImage: user.photo);
      } catch (e) {
        print(e);
        yield UserErrorState(error: e.toString());
      }
    } else if (event is UserImageUpdateEvent) {
      try {
        final profileImage = event.profileImage;
        final success = await client.uploadImage(_uploadUrl, profileImage);
        if (success) {
          yield UserImageUpdatedState(profileImage: profileImage);
        } else {
          yield UserErrorState(error: "Failed to load image");
        }
      } catch (e) {
        print(e);
        yield UserErrorState(error: "Failed to load image");
      }
    } else {
      yield UserErrorState(error: "No event map");
    }
  }
}
