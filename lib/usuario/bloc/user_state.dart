part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserFetchedState extends UserState {}

class UserErrorState extends UserState {
  String error;
}
