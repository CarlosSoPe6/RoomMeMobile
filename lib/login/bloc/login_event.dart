part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginLocalEvent extends LoginEvent {
  final String email;
  final String password; 

  LoginLocalEvent({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

