import 'package:RoomMeMobile/homepage/house_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_bloc.dart';

class Home extends StatefulWidget {
  final List houses;

  Home({Key key, @required this.houses}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc _bloc;
  Future<void> onCreateHouse(BuildContext context) async {
    await Navigator.of(context).pushNamed('/house/new');
    _bloc.add(InitialEvent(houses: _bloc.client.getUserId()));
  }

  void Function(int) onTapHouse(BuildContext context) {
    void onTapClosure(int hid) {
      Navigator.of(context)
          .pushNamed('/house/detail', arguments: hid)
          .then((value) {
        BlocProvider.of<HomeBloc>(context)
            .add(InitialEvent(houses: _bloc.client.getUserId()));
      });
    }

    return onTapClosure;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.houses);
    double width = MediaQuery.of(context).size.width;
    final double cardWidth = width * 0.8;
    final double cardHeight = (cardWidth / 16) * 9;

    return Scaffold(
        appBar: AppBar(
          title: Text('Mis casas'),
          actions: [
            IconButton(
                icon: Icon(Icons.add), onPressed: () => onCreateHouse(context)),
            IconButton(
                icon: Icon(Icons.people),
                onPressed: () {
                  Navigator.of(context).pushNamed('/user/me');
                })
          ],
        ),
        body: BlocProvider<HomeBloc>(
            create: (context) {
              _bloc = HomeBloc();
              _bloc.add(InitialEvent(houses: _bloc.client.getUserId()));
              return _bloc;
            },
            child:
                BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
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
            }, builder: (context, state) {
              if (state is InitialState) {
                if (state.body.length > 0)
                  return RefreshIndicator(
                      child: ListView.builder(
                          padding: EdgeInsets.all((width - cardWidth) / 2),
                          itemCount: state.body.length,
                          itemBuilder: (BuildContext context, int index) {
                            return HouseItem(
                                onTapHouse: onTapHouse(context),
                                cardWidth: cardWidth,
                                cardHeight: cardHeight,
                                house: state.body[index]);
                          }),
                      onRefresh: () async {
                        _bloc.add(InitialEvent(houses: 24));
                      });
                else
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('Sin casas disponibles'),
                        ),
                        RaisedButton(onPressed: () => onCreateHouse(context))
                      ],
                    ),
                  );
              } else
                return Center(child: Text('Sin casas disponibles'));
            })));
  }
}
