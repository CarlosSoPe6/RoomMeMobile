import 'package:flutter/material.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis casas'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Text('Casa de Maki', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
              onTap: () {
                print('Casa de Maki');
                // Navigator.of(context).pushReplacementNamed('/register');
              }
            )
          ]
        )
      )
    );
  }
}
