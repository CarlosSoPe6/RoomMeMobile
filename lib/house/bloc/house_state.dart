part of 'house_bloc.dart';

@immutable
abstract class HouseState {}

class HouseInitial extends HouseState {}

class HouseFetchedState extends HouseState {
  final House house;

  HouseFetchedState({this.house});
}

class HouseCreateState extends HouseState {
  final House house;

  HouseCreateState({this.house});
}

class HouseErrorState extends HouseState {
  final String error;

  HouseErrorState({this.error});
}
