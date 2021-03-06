part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  final String ts;

  LoginSuccessState({@required this.ts});

  @override
  List<Object> get props => [ts];
}

class LoginErrorState extends LoginState {
  final String error;

  // TODO: define and use codes
  LoginErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}
