part of 'main_bloc.dart';

abstract class CustomEvent extends Equatable {
const CustomEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends CustomEvent {}

class RegisterEvent extends CustomEvent {
  final String name;
  final String lastname;
  final String email;
  final String password;

  RegisterEvent({
    @required this.name,
    @required this.lastname,
    @required this.email,
    @required this.password
  });
}

class GetAllUsersEvent extends CustomEvent {
  @override
  List<Object> get props => [];
}
