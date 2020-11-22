part of 'house_bloc.dart';

@immutable
abstract class HouseState {}

class HouseInitial extends HouseState {}

class HouseFetchedState extends HouseState {
  final House house;

  HouseFetchedState({this.house});
}

class HouseCreateState extends HouseState {
  HouseCreateState();
}

class HouseErrorState extends HouseState {
  final String error;

  HouseErrorState({this.error});
}

class HomeActionSuccess extends HouseState {}
