import 'package:RoomMeMobile/homepage/house_item.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_bloc.dart';


class Home extends StatefulWidget {

  final List houses;

  Home({
    Key key,
    @required this.houses
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    print(widget.houses);
    double width = MediaQuery.of(context).size.width;
    final double cardWidth = width*0.8;
    final double cardHeight = (cardWidth/16)*9;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis casas'),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc()..add(InitialEvent(houses: 24)),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            // para mostrar dialogos o snackbars
            if (state is ErrorState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text("Error: ${state.error}")),
                );
            }
            // } else if(state is RegisteredState) {
              // Scaffold.of(context)
              //   ..hideCurrentSnackBar()
              //   ..showSnackBar(
              //     SnackBar(content: Text("Successful registration")),
              //   );
              // sleep(Duration(seconds: 1));
              // Navigator.of(context).pushReplacementNamed('/home', arguments: new List());
            // }
          },
          builder: (context, state) {
            if (state is InitialState){
              dynamic data = state.body;
              return ListView.builder(
                padding: EdgeInsets.all((width - cardWidth)/2),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return HouseItem(cardWidth: cardWidth, cardHeight: cardHeight, url: data['foto'], houseName: data['title']);
                }
              );
            } else
              return Center(child: Text('No houses available'));
          }
        )
      )
    );
  }
}
