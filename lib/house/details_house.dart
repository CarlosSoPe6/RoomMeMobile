import 'package:RoomMeMobile/house/bloc/house_bloc.dart';
import 'package:flutter/material.dart';

class DetailsHouse extends StatefulWidget {
  @override
  _DetailsHouseState createState() => _DetailsHouseState();
}

class _DetailsHouseState extends State<DetailsHouse> {
  HouseBloc _houseBloc;

  @override
  void dispose() {
    _houseBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Stack(
          children: [
            Image.network(''),
            Container(
              child: Column(
                children: [Text("data1"), Text("data2")],
              ),
            )
          ],
        ));
  }
}
