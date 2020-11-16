part of 'main_bloc.dart';

abstract class CustomState extends Equatable {
  const CustomState();

  @override
  List<Object> get props => [];
}

class InitialState extends CustomState {}

class RegisteredState extends CustomState {}

class ErrorState extends CustomState {
  final String error;

  ErrorState({@required this.error});
  @override
  List<Object> get props => [error];
}
