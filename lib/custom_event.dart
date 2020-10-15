part of 'main_bloc.dart';

abstract class CustomEvent extends Equatable {
const CustomEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends CustomEvent {}

class RegisterEvent extends CustomEvent {}

class GetAllUsersEvent extends CustomEvent {
  @override
  List<Object> get props => [];
}
