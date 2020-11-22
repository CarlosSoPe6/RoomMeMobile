part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class InitialState extends DashboardState {

  InitialState();

  @override
  List<Object> get props => [];
}

class TaskCreatedState extends DashboardState {

  final List<Map<String, dynamic>> houses;

  TaskCreatedState({this.houses});

  @override
  List<Object> get props => [houses];
}

class ErrorState extends DashboardState {
  final String error;

  ErrorState({@required this.error});
  @override
  List<Object> get props => [error];
}
