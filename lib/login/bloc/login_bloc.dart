import 'dart:async';
import 'dart:convert';

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
    } else if(event is LoginLocalEvent) {
      int result = await _loginRequest(jsonEncode({
        'email': event.email,
        'password': event.password
      }));
      if(result == 0){
        yield LoginErrorState(error: "Usuario o Contraseña incorrectos");
      }else if(result == 1){
        yield LoginSuccessState();
      }else{
        yield LoginErrorState(error: "Error al conectar con el servidor");
      }
    }
  }

  Future<int> _loginRequest(body) async {
    try {
      Response response = await post(_link, headers:{"Content-type": "application/json"}, body: body);
        if(response.statusCode == 401) {
          return 0;
        }
      return 1;
    } catch(error) {
      print(error);
      return 2;
    }
  }
}
