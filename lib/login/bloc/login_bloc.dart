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
  final _link = "http://192.168.1.65:3000/api/login";

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is InitialEvent) {
      yield LoginInitial();
    } else if(event is LoginLocalEvent) {
      bool result = await _loginRequest(jsonEncode({
        'email': event.email,
        'password': event.password
      }));
      if(!result){
        yield LoginErrorState(error: "Usuario o Contraseña incorrectos");
      }else{
        yield LoginSuccessState();
      }
    }
  }

  Future<bool> _loginRequest(body) async {
    Response response = await post(_link, headers:{"Content-type": "application/json"}, body: body);
      if(response.statusCode == 401) {
        return false;
      }
    return true;
  }
}
