import 'dart:async';
import 'dart:convert';

import 'package:RoomMeMobile/http/client.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  final _link = "https://room-me-app.herokuapp.com/api/login";

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is InitialEvent) {
      yield LoginInitial();
    } else if (event is LoginLocalEvent) {
      int result = await _loginRequest(event.email, event.password);
      if (result == 0) {
        yield LoginErrorState(error: "Usuario o Contraseña incorrectos");
      } else if (result == 1) {
        yield LoginSuccessState(ts: DateTime.now().toIso8601String());
      } else {
        yield LoginErrorState(error: "Error al conectar con el servidor");
      }
    }
  }

  Future<int> _loginRequest(email, password) async {
    try {
      HttpClient c = HttpClient.getClient();
      var response = await c.login(email, password);
      return response ? 1 : 0;
    } catch (error) {
      print(error);
      return 2;
    }
  }
}
