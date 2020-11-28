import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dashboard_bloc.dart';

class DashboardPage extends StatefulWidget {
  final List houses;

  DashboardPage({Key key, @required this.houses}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool changed = false;
  DashboardBloc dBloc;
  List houses2;

  @override
  Widget build(BuildContext context) {
    if (houses2 == null) houses2 = widget.houses;

    double width = MediaQuery.of(context).size.width;

    TextEditingController _desCtrl = new TextEditingController();
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, changed);
          return true;
        },
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('Tareas'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop(changed);
                },
              ),
            ),
            body: BlocProvider(
                create: (context) {
                  dBloc = DashboardBloc();
                  return dBloc;
                },
                child: BlocConsumer<DashboardBloc, DashboardState>(
                    listener: (context, state) {
                  if (state is ErrorState) {
                    Scaffold.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text("Error: ${state.error}")),
                      );
                  } else if (state is TaskCreatedState) {
                    houses2 = state.houses;
                    changed = true;
                    Scaffold.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text("Tarea creada")),
                      );
                  }
                }, builder: (context, state) {
                  return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: houses2.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Row(children: [
                            Container(
                                width: houses2[index]['title'].length * 14 >=
                                        width / 2
                                    ? width / 2
                                    : houses2[index]['title'].length * 14.0,
                                child: Text(houses2[index]['title'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 36,
                                    ))),
                            IconButton(
                              icon: Icon(Icons.add_circle),
                              color: Color(0xFF8FD8D2),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: Text('Tarea nueva'),
                                          content: TextField(
                                              controller: _desCtrl,
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  labelText: 'Descripción')),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  if (_desCtrl.text
                                                          .trim()
                                                          .length >
                                                      0)
                                                    dBloc.add(CreateTaskEvent(
                                                        description: _desCtrl
                                                            .text
                                                            .trim(),
                                                        hid: houses2[index]
                                                            ['hid']));
                                                  else
                                                    _scaffoldKey.currentState
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                'Por favor ingrese una descripción')));
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Crear')),
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Calcelar'))
                                          ]);
                                    });
                              },
                              iconSize: 18,
                            )
                          ]),
                          Container(
                              height: width / 2,
                              child: ListView.builder(
                                  itemCount: houses2[index]['tasks'].length,
                                  itemBuilder: (context, index2) {
                                    return Text(houses2[index]['tasks'][index2]
                                        ['description']);
                                  }))
                        ]);
                      });
                }))));
  }
}
