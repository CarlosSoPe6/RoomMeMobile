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
  final String ts;

  LoginLocalEvent(
      {@required this.email, @required this.password, @required this.ts});

  @override
  List<Object> get props => [ts, email, password];
}
