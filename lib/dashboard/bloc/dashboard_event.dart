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

class DeleteTaskEvent extends DashboardEvent {
  final int id;

  DeleteTaskEvent({this.id});

  @override
  List<Object> get props => [id];
}

class EditTaskEvent extends DashboardEvent {
  final dynamic task;

  EditTaskEvent({this.task});

  @override
  List<Object> get props => [task];
}
