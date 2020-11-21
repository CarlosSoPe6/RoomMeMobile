import 'package:flutter/material.dart';


class HouseItem extends StatefulWidget {

  final double cardHeight;
  final double cardWidth;
  final dynamic house;

  HouseItem({
    Key key,
    @required this.cardHeight,
    @required this.cardWidth,
    @required this.house
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
      margin: EdgeInsets.only(bottom: width/10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed('/house/detail');
        },
        child: Column(
        children:[
          Image.network(
            widget.house['foto'],
            fit: BoxFit.fill,
            height: widget.cardHeight/4*3,
            width: widget.cardWidth
          ),
          Container(
            height: widget.cardHeight/4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Container(
                    width: widget.cardWidth - 160,
                    child: Text(widget.house['title'], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
                  )
                ),
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.content_paste), onPressed: (){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Tareas'),
                            content: Container(
                              height: width/2,
                              width: width/5*3,
                              child: widget.house['tasks'].length > 0 ? ListView.builder(
                                itemCount: widget.house['tasks'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      Text(widget.house['tasks'][index]['description']),
                                      widget.house['tasks'][index]['complete'] ? Icon(Icons.check) : Container()
                                    ]
                                  );
                                }
                              ) : Center( child: Text('Sin tareas por hacer'))
                            ),
                            actions: [
                              FlatButton(onPressed: (){ Navigator.of(context).pop();}, child: Text('OK'))
                            ]
                          );
                        }
                      );
                    }),
                    IconButton(icon: Icon(Icons.people), onPressed: (){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Miembros'),
                            content: Container(
                              height: width/2,
                              width: width/5*3,
                              child: ListView.builder(
                                itemCount: widget.house['members'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      Icon(Icons.person),
                                      Text(widget.house['members'][index]['name'] + ' ' + widget.house['members'][index]['lastName'])
                                    ]
                                  );
                                }
                              )
                            ),
                            actions: [
                              FlatButton(onPressed: (){ Navigator.of(context).pop();}, child: Text('OK'))
                            ]
                          );
                        }
                      );
                    }),
                    IconButton(
                      icon: Icon(Icons.chat_bubble, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/chat');
                      }
                    )
                  ]
                )
              ]
            )
          )
        ]
      )
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      )
    );
  }
}