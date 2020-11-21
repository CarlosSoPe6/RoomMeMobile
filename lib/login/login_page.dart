import 'package:RoomMeMobile/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color iconColor = Colors.grey;
  bool obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Inicio de Sesión"),
        ),
        body: BlocProvider(
            create: (context) {
              _loginBloc = LoginBloc();
              return _loginBloc..add(InitialEvent());
            },
            child:
                BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
              print(state);
              if (state is LoginErrorState) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text("Error: ${state.error}")),
                  );
                _loginBloc.add(InitialEvent());
              } else if (state is LoginSuccessState) {
                Navigator.of(context)
                    .popAndPushNamed('/home', arguments: new List());
              }
            }, builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(70.0),
                      child: Container(
                          child: Text(
                        "RoomMe",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      )),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          filled: true,
                        ),
                        validator: (text) =>
                            text.isEmpty ? "Ingrese su correo" : null,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            filled: true,
                            labelText: "Password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                    if (obscureText) {
                                      iconColor = Colors.grey;
                                    } else {
                                      iconColor = Colors.black;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove_red_eye,
                                    color: iconColor))),
                        obscureText: obscureText,
                        validator: (text) =>
                            text.isEmpty ? "Ingrese su contraseña" : null,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    RaisedButton(
                        child: Text("INICIAR SESIÓN"),
                        color: Color(0xFFFEDCD2),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _loginBloc.add(LoginLocalEvent(
                                email: _emailController.text,
                                password: _passwordController.text));
                          }
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/register');
                        },
                        child: Text(
                          "Crear una cuenta",
                          style: TextStyle(
                              color: Colors.lightBlue,
                              decoration: TextDecoration.underline),
                        ))
                  ]),
                ),
              );
            })));
  }
}
