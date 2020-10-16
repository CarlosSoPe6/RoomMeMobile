part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserFetchedState extends UserState {
  final User user;
  UserFetchedState({this.user});
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState({this.error});
}
