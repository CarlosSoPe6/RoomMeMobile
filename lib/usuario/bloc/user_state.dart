part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserFetchedState extends UserState {
  final User user;
  final String profileImage;
  final List<Contact> contacts;
  UserFetchedState({this.user, this.profileImage, this.contacts});
}

class UserImageUpdatedState extends UserState {
  final File profileImage;
  UserImageUpdatedState({this.profileImage});
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState({this.error});
}
