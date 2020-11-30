import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/main_bloc.dart';


class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}


class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordHidden = true;


  register(BuildContext context) {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<MainBloc>(context).add(RegisterEvent(
        name: _nameController.text,
        lastname: _lastnameController.text,
        email: _emailController.text,
        password: _passwordController.text
      ));
    } else {
      return Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text("Complete el formulario"),
          ),
        );
    }
  }
  
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        automaticallyImplyLeading: false
      ),
      body: BlocProvider(
        create: (context) => MainBloc()..add(InitialEvent()),
        child: BlocConsumer<MainBloc, CustomState>(
          listener: (context, state) {
            if (state is ErrorState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text("Error: ${state.error}")),
                );
            } else if(state is RegisteredState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text("Successful registration")),
                );
              sleep(Duration(seconds: 1));
              Navigator.of(context).pushReplacementNamed('/home');
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/8),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: width/6, bottom: width/8),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'Nombre'
                            ),
                            validator: (text) {
                              if (text.isEmpty)
                                return "Ingrese su nombre";
                              else
                                return null;
                            }
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: width/8),
                          child: TextFormField(
                            controller: _lastnameController,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'Apellido'
                            ),
                            validator: (text) {
                              if (text.isEmpty)
                                return "Ingrese su apellido";
                              else
                                return null;
                            }
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: width/8),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'Correo electrónico'
                            ),
                            validator: (text) {
                              if (text.isEmpty)
                                return "Ingrese su correo electrónico";
                              else
                                return null;
                            }
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: width/8),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'Contraseña',
                              suffixIcon: IconButton(
                                icon: Icon(_passwordHidden ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _passwordHidden = !_passwordHidden;
                                  });
                                }
                              )
                            ),
                            obscureText: _passwordHidden,
                            validator: (text) {
                              if (text.isEmpty)
                                return "Ingrese una contraseña";
                              else
                                return null;
                            }
                          )
                        ),
                        RaisedButton(
                          onPressed: (){
                            register(context);
                          },
                          child: Text('REGISTRAR'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: width/8),
                          child: GestureDetector(
                          child: Text('Iniciar sesión', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed('/login');
                          }
                        )
                        )
                      ]
                    )
                  )
                )
              ]
            );
          }
        )
      )
    );
  }
}
