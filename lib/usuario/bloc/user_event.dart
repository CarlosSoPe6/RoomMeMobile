part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserFetchEvent extends UserEvent {
  final int uid;
  UserFetchEvent({this.uid});
}


class UserUpdateName extends UserEvent {
  final String name;
  final String lastName;
  UserUpdateName({this.name, this.lastName});
}

class UserUpdateContact extends UserEvent {
  final int index;
  final String name;
  final String phone;
  UserUpdateContact({this.index, this.name, this.phone});
}

class UserAddContact extends UserEvent {
  final String name;
  final String phone;
  UserAddContact({this.name, this.phone});
}

class UserDeleteContact extends UserEvent {
  final int index;
  UserDeleteContact({this.index});
}

class UserImageUpdateEvent extends UserEvent {
  final File profileImage;
  UserImageUpdateEvent({this.profileImage});
}
