import 'package:flutter/material.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

  double width = MediaQuery.of(context).size.width;
  final double cardWidth = width*0.8;
  final double cardHeight = (cardWidth/16)*9;
  final Color cardColor = Color(0xFFa65d4b);


    return Scaffold(
      appBar: AppBar(
        title: Text('Mis casas'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: (width - cardWidth)/2, vertical: 50),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.only(bottom: width/10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: cardColor,
                  child: Container(height: cardHeight)
                ),
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.only(bottom: width/10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: cardColor,
                  child: Container(height: cardHeight)
                ),
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.only(bottom: width/10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: cardColor,
                  child: Container(height: cardHeight)
                ),
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.only(bottom: width/10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: cardColor,
                  child: Container(height: cardHeight)
                ),
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.only(bottom: width/10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: cardColor,
                  child: Container(height: cardHeight)
                ),
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.only(bottom: width/10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: cardColor,
                  child: Container(height: cardHeight)
                ),
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.only(bottom: width/10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: cardColor,
                  child: Container(height: cardHeight)
                ),
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
        ]
      )
    );
  }
}
