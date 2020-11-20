import 'package:flutter/material.dart';

class HouseItem extends StatefulWidget {
  final double cardHeight;
  final double cardWidth;
  final String url;
  final String houseName;
  final int hid;

  HouseItem({
    Key key,
    @required this.cardHeight,
    @required this.cardWidth,
    @required this.url,
    @required this.houseName,
    @required this.hid,
  }) : super(key: key);

  @override
  _HouseItemState createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Card(
        elevation: 4,
        semanticContainer: true,
        margin: EdgeInsets.only(bottom: width / 10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                '/house/detail',
                arguments: widget.hid,
              );
            },
            child: Column(children: [
              Image.network(widget.url,
                  fit: BoxFit.fill,
                  height: widget.cardHeight / 4 * 3,
                  width: widget.cardWidth),
              Container(
                  height: widget.cardHeight / 4,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Container(
                                width: widget.cardWidth - 160,
                                child: Text(widget.houseName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)))),
                        Row(children: [
                          IconButton(
                              icon: Icon(Icons.content_paste),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.people), onPressed: () {}),
                          IconButton(
                              icon:
                                  Icon(Icons.chat_bubble, color: Colors.black),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/chat');
                              })
                        ])
                      ]))
            ])),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)));
  }
}
