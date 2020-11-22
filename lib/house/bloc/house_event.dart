part of 'house_bloc.dart';

@immutable
abstract class HouseEvent {}

class HouseFetchEvent extends HouseEvent {
  final int hid;

  HouseFetchEvent({this.hid});
}

class HouseSaveEvent extends HouseEvent {
  final House house;
  final bool isNew;
  HouseSaveEvent({this.isNew, this.house});
}

class HouseUpdateFotoEvent extends HouseEvent {
  final File file;
  HouseUpdateFotoEvent({@required this.file});
}

class AddHousmatesEvent extends HouseEvent {
  
  AddHousmatesEvent();

}
class HouseCreateEvent extends HouseEvent {}
