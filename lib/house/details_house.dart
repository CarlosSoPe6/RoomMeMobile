import 'package:flutter/material.dart';

class DetailsHouse extends StatefulWidget {
  @override
  _DetailsHouseState createState() => _DetailsHouseState();
}

class _DetailsHouseState extends State<DetailsHouse> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Container());
  }
}
