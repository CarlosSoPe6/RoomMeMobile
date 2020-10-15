import 'dart:async';

import 'package:RoomMeMobile/models/house.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'house_event.dart';
part 'house_state.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {
  House house;

  HouseBloc() : super(HouseInitial());

  @override
  Stream<HouseState> mapEventToState(
    HouseEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
