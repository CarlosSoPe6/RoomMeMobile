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

class UserUpdateEvent extends UserEvent {
  final User user;
  final File profileImage;
  UserUpdateEvent({this.profileImage, this.user});
}

class CreateContactEvent extends UserEvent {
  final Contact contact;
  CreateContactEvent({this.contact});
}

class DeleteContactEvent extends UserEvent {
  final int uid;
  DeleteContactEvent({this.uid});
}

class UpdateContactEvent extends UserEvent {
  final Contact contact;
  UpdateContactEvent({this.contact});
}
