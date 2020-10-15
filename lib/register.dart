import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_bloc.dart';


class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: BlocProvider(
        create: (context) => MainBloc()..add(InitialEvent()),
        child: BlocConsumer<MainBloc, CustomState>(
          listener: (context, state) {
            // para mostrar dialogos o snackbars
            if (state is ErrorState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text("Error: ${state.error}")),
                );
            } else if(state is ShowUsersState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text("Successful registration")),
                );
            }
          },
          builder: (context, state) {
            return ListView(
              // physics: ScrollPhysics(),
              // shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/8),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: width/6, bottom: width/8),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0)
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Nombre'
                          )                        
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: width/8),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0)
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Apellidos'
                          )
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: width/8),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0)
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Correo electrónico'
                          )
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: width/8),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0)
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Contraseña'                       
                          ),
                          obscureText: true,
                        )
                      ),
                      RaisedButton(
                        onPressed: (){
                          BlocProvider.of<MainBloc>(context).add(RegisterEvent());
                        },
                        child: Text('REGISTRAR'),
                      )
                    ]
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
