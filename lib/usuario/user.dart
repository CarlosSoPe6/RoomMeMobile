import 'dart:io';
import 'package:RoomMeMobile/usuario/bloc/user_bloc.dart';
import 'package:RoomMeMobile/usuario/user_contact_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum Product { Galeria, Camara }

class UserPage extends StatefulWidget {
  @override
  File f = File(
      'https://res.cloudinary.com/dgahmwjbv/image/upload/v1602784593/WhatsApp_Image_2020-10-15_at_12.29.43_PM_e8unq1.jpg');
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _picker = ImagePicker();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userLastnameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPhoneController = TextEditingController();
  String _name = "";
  UserBloc _userBloc;
  File _profileImage;

  _displayPhotoDialog(BuildContext context) async {
    return await showDialog<Product>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Reemplazar imagen desde: '),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () async {
                final pickedImage =
                    await _picker.getImage(source: ImageSource.gallery);
                final image = File(pickedImage.path);
                _userBloc.add(UserImageUpdateEvent(profileImage: image));
                Navigator.of(context).pop();
              },
              child: const Text('Galeria'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                final pickedImage =
                    await _picker.getImage(source: ImageSource.camera);
                final image = File(pickedImage.path);
                _userBloc.add(UserImageUpdateEvent(profileImage: image));
                Navigator.of(context).pop();
              },
              child: const Text('Cámara'),
            ),
          ],
        );
      },
    );
  }

  _displayNameDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cambio de nombre'),
            content: Column(
              children: [
                TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(hintText: "Nombre"),
                ),
                TextField(
                  controller: _userLastnameController,
                  decoration: InputDecoration(hintText: "Apellido"),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget _userView(BuildContext context, double width) {
    return Center(
      child: SingleChildScrollView(
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
                            onTap: () {
                              _displayPhotoDialog(context);
                            },
                            child: ClipRRect(
                              child: Image(
                                height: 100,
                                width: 100,
                                image: FileImage(
                                  _profileImage,
                                ),
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
                                  Text(_name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 20, right: 0),
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _displayNameDialog(context);
                            },
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.w300)),
                              TextField(
                                controller: _userEmailController,
                              )
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.w300)),
                              TextField(
                                controller: _userPhoneController,
                              )
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
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Contactos de emergencia",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: SizedBox(
                width: width - 20,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return new UserContactItem(
                        index: index, name: 'Carlos Soto', phone: '1234567890');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
        actions: [
         
        ],
      ),
      body: BlocProvider(
        create: (context) {
          _userBloc = UserBloc()..add(UserFetchEvent(uid: 24));
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
          if (state is UserFetchedState) {
            _userEmailController.text = state.user.email;
            _userPhoneController.text = state.user.phone;
            _name = state.user.name + " " + state.user.lastName;
            _userNameController.text = state.user.name;
            _userLastnameController.text = state.user.lastName;
            _profileImage = state.profileImage;
          }
        }, builder: (context, state) {
          if (state is UserFetchedState) {
            return _userView(context, width);
          }
          return Container(
              // child: Center(
              //   child: CircularProgressIndicator(),
              // ),
              );
        }),
      ),
    );
  }
}
