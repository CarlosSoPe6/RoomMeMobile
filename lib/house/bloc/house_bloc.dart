import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'house_event.dart';
part 'house_state.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {
  HouseBloc() : super(HouseInitial());

  @override
  Stream<HouseState> mapEventToState(
    HouseEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
