import 'dart:async';

import 'package:RoomMeMobile/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  User user;

  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserFetchEvent) {
      yield UserFetchedState();
    } else {
      yield UserErrorState();
    }
  }
}
