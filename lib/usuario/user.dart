import 'package:RoomMeMobile/usuario/bloc/user_bloc.dart';
import 'package:RoomMeMobile/usuario/user_contact_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserBloc _userBloc;

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: BlocProvider(
        create: (context) {
          _userBloc = UserBloc()..add(UserFetchEvent());
          return _userBloc;
        },
        child: BlocConsumer<UserBloc, UserState>(listener: (context, state) {
          if (state is UserErrorState) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text("Error: ${state.error}")),
              );
          }
        }, builder: (context, state) {
          return Center(
            child: Column(
              children: [
                Padding(
                  child: Container(
                    width: width - 20,
                    child: Card(
                        child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: GestureDetector(
                                onTap: () => {},
                                child: ClipRRect(
                                  child: Image(
                                    height: 100,
                                    width: 100,
                                    image: NetworkImage(
                                        "https://res.cloudinary.com/dgahmwjbv/image/upload/v1602784593/WhatsApp_Image_2020-10-15_at_12.29.43_PM_e8unq1.jpg"),
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                )),
                          ),
                        ),
                        // Text View
                        Stack(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Text("Maky la Perra",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700)),
                                      Text("Guadalajara, JAL",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300))
                                    ],
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 20, right: 0),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              width: width - 20,
                              child: Column(
                                children: [
                                  Text("Correo",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300)),
                                  TextField()
                                ],
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              width: width - 20,
                              child: Column(
                                children: [
                                  Text("Teléfono",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300)),
                                  TextField()
                                ],
                              ),
                            ))
                      ],
                    )),
                  ),
                  padding: EdgeInsets.only(top: 10),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    width: width - 20,
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Contactos de emergencia",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            child: SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return new UserContactItem(
                                      name: 'Carlos Soto', phone: '1234567890');
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
