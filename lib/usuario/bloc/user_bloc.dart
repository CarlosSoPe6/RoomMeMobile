import 'dart:async';
import 'dart:io';

import 'package:RoomMeMobile/http/client.dart';
import 'package:RoomMeMobile/models/contact.dart';
import 'package:RoomMeMobile/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final String _url = "https://room-me-app.herokuapp.com/user/";
  final String _uploadUrl =
      "https://room-me-app.herokuapp.com/image/upload/user";
  final String _contactUrl = "https://room-me-app.herokuapp.com/contact";
  final String _updateUrl = "https://room-me-app.herokuapp.com/user/me";
  HttpClient client;
  User user;
  List<Contact> contacts = List<Contact>();

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
        await fetchUserInfo(uid);
        yield UserFetchedState(
          user: user,
          profileImage: user.photo,
          contacts: contacts,
        );
      } catch (e) {
        print(e);
        yield UserErrorState(error: e.toString());
      }
    } else if (event is UserUpdateEvent) {
      try {
        final eventUser = event.user;
        final profileImage = event.profileImage;
        await client.put(_updateUrl, eventUser.toJson());
        if (profileImage != null) {
          await client.uploadImage(_uploadUrl, profileImage);
        }
        final uid = client.getUserId();
        await fetchUserInfo(uid);
        yield UserFetchedState(
          user: user,
          profileImage: user.photo,
          contacts: contacts,
        );
      } catch (e) {
        print(e);
        yield UserErrorState(error: "Failed to load image");
      }
    } else if (event is CreateContactEvent) {
      final contact = event.contact;
      final uid = client.getUserId();
      final response = await client.post(_contactUrl, contact.toJson());
      print(response);
      await fetchUserInfo(uid);
      yield UserFetchedState(
        user: user,
        profileImage: user.photo,
        contacts: contacts,
      );
    } else if (event is UpdateContactEvent) {
      final contact = event.contact;
      final uid = contact.uid;
      final uri = "$_contactUrl/$uid";
      final response = await client.patch(uri, contact.toJson());
      print(response);
      await fetchUserInfo(client.getUserId());
      yield UserFetchedState(
        user: user,
        profileImage: user.photo,
        contacts: contacts,
      );
    } else if (event is DeleteContactEvent) {
      final uid = event.uid;
      final uri = "$_contactUrl/$uid";
      final response = await client.delete(uri, null);
      print(response);
      await fetchUserInfo(client.getUserId());
      yield UserFetchedState(
        user: user,
        profileImage: user.photo,
        contacts: contacts,
      );
    } else if (event is CreateContactEvent) {
      final contact = event.contact;
      final response = await client.post(_contactUrl, contact.toJson());
      print(response);
      await fetchUserInfo(client.getUserId());
      yield UserFetchedState(
        user: user,
        profileImage: user.photo,
        contacts: contacts,
      );
    } else {
      yield UserErrorState(error: "No event map");
    }
  }

  Future<void> fetchUserInfo(int uid) async {
    String uri = "$_url$uid";
    var userResponse = await client.get(uri.toString(), null);
    user = User.fromJson(userResponse);
    var contactResponse = await client.get("$uri/contacts", null);
    var rawContact = List.from(contactResponse);
    contacts = List<Contact>();
    rawContact.forEach((entry) {
      contacts.add(Contact.fromJson(entry));
    });
  }
}
