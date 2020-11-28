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

class TaskChengedState extends DashboardState {

  final List<Map<String, dynamic>> houses;
  final int action;

  TaskChengedState({this.houses, this.action});

  @override
  List<Object> get props => [houses, action];
}

class ErrorState extends DashboardState {
  final String error;

  ErrorState({@required this.error});
  @override
  List<Object> get props => [error];
}
