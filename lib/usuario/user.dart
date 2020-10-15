import 'package:RoomMeMobile/usuario/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserBloc _userBloc;

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: BlocProvider(
          create: (context) {
            _userBloc = UserBloc()..add(null);
          },
          child: Stack(
            children: [
              Image.network(''),
              Container(
                child: Column(
                  children: [Text("data1"), Text("data2")],
                ),
              )
            ],
          ),
        ));
  }
}
