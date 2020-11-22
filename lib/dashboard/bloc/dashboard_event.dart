part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
const DashboardEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends DashboardEvent {
  InitialEvent();
}

class GetHousesEvent extends DashboardEvent {
  GetHousesEvent();
}

class CreateTaskEvent extends DashboardEvent {
  final String description;
  final int hid;

  CreateTaskEvent({this.description, this.hid});

  @override
  List<Object> get props => [description, hid];
}
