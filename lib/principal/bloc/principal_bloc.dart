import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'principal_event.dart';
part 'principal_state.dart';

class PrincipalBloc extends Bloc<PrincipalEvent, PrincipalState> {
  PrincipalBloc() : super(PrincipalInitial());

  @override
  Stream<PrincipalState> mapEventToState(
    PrincipalEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
