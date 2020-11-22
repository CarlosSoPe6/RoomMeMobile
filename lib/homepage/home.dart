import 'package:RoomMeMobile/homepage/house_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_bloc.dart';

class Home extends StatefulWidget {


  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc _bloc;
  Future<void> onCreateHouse(BuildContext context) async {
    await Navigator.of(context).pushNamed('/house/new');
    _bloc.add(InitialEvent());
  }

  void Function(int) onTapHouse(BuildContext context) {
    void onTapClosure(int hid) {
      Navigator.of(context)
          .pushNamed('/house/detail', arguments: hid)
          .then((value) {
        BlocProvider.of<HomeBloc>(context)
            .add(InitialEvent());
      });
    }

    return onTapClosure;
  }

  HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final double cardWidth = width*0.8;
    final double cardHeight = (cardWidth/16)*9;
    List houses = new List();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis casas'),
        actions: [
          IconButton(icon: Icon(Icons.person), onPressed: (){
            Navigator.of(context).pushNamed('/user/me');
          }),
          IconButton(icon: Icon(Icons.pie_chart), onPressed: () async {
            bool changes = await Navigator.of(context).pushNamed('/dashboard', arguments: houses);
            if (changes)
              bloc.add(InitialEvent());
          })
        ],
      ),
      body: BlocProvider(
        create: (context) {
          bloc = HomeBloc();
          bloc.add(InitialEvent());
          return bloc;
        },
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is ErrorState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text("Error: ${state.error}")),
                );
            }
          },
          builder: (context, state) {
            if (state is InitialState){
              houses = state.body;
              if(state.body.length > 0)
                return RefreshIndicator(
                  child: ListView.builder(
                    padding: EdgeInsets.all((width - cardWidth)/2),
                    itemCount: state.body.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HouseItem(
                        onTapHouse: onTapHouse(context),
                        cardWidth: cardWidth,
                        cardHeight: cardHeight,
                        house: state.body[index]);
                    }
                  ),
                  onRefresh: () async {
                    bloc.add(InitialEvent());
                  }
                );
              else
                return Center(child: Text('Sin casas disponibles'));
            }
          }
        )
      )
    );
  }
}
