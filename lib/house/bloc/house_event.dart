part of 'house_bloc.dart';

@immutable
abstract class HouseEvent {}

class HouseFetchEvent extends HouseEvent {
  final int hid;

  HouseFetchEvent({this.hid});
}

class HouseEditEvent extends HouseEvent {
  final int hid;

  HouseEditEvent({this.hid});
}

class HouseCreateEvent extends HouseEvent {}
