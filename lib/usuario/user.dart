import 'dart:io';
import 'package:RoomMeMobile/models/contact.dart';
import 'package:RoomMeMobile/models/user.dart';
import 'package:RoomMeMobile/usuario/bloc/user_bloc.dart';
import 'package:RoomMeMobile/usuario/user_contact_item.dart';
import 'package:RoomMeMobile/utils/LocalNetImageProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum Product { Galeria, Camara }

class UserPage extends StatefulWidget {
  final bool isMe;
  final int uid;
  UserPage({@required this.isMe, this.uid});

  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _picker = ImagePicker();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userLastnameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPhoneController = TextEditingController();

  final TextEditingController _contactoNombreController =
      TextEditingController();
  final TextEditingController _contactoApellidoController =
      TextEditingController();
  final TextEditingController _contactoPhoneController =
      TextEditingController();
  String _name = "";
  UserBloc _userBloc;
  String _profileImage;
  File image = null;

  User _stateUser;

  @override
  void initState() {
    super.initState();
    _profileImage =
        "https://vimcare.com/assets/empty_user-e28be29d09f6ea715f3916ebebb525103ea068eea8842da42b414206c2523d01.png";
  }

  void deleteContactCallback(int uid) {
    _userBloc.add(DeleteContactEvent(uid: uid));
  }

  void updateContactCallback(
      Contact c, String nombre, String apellido, String phone) {
    final updateContact = new Contact(
      uid: c.uid,
      userId: c.userId,
      name: nombre,
      lastName: apellido,
      email: c.email,
      phone: phone,
    );
    _userBloc.add(UpdateContactEvent(contact: updateContact));
  }

  void createContactCallback(String nombre, String apellido, String phone) {
    final updateContact = new Contact(
      uid: 0,
      userId: this._userBloc.client.getUserId(),
      name: nombre,
      lastName: apellido,
      email: "",
      phone: phone,
    );
    _userBloc.add(CreateContactEvent(contact: updateContact));
  }

  void _showAddUser(BuildContext context) async {
    _contactoNombreController.clear();
    _contactoApellidoController.clear();
    _contactoPhoneController.clear();
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Crear contacto'),
            content: Column(
              children: [
                TextField(
                  controller: _contactoNombreController,
                  decoration: InputDecoration(hintText: "Nombre"),
                ),
                TextField(
                  controller: _contactoApellidoController,
                  decoration: InputDecoration(hintText: "Apellido"),
                ),
                TextField(
                  controller: _contactoPhoneController,
                  decoration: InputDecoration(hintText: "Teléfono"),
                ),
              ],
            ),
            actions: [
              new FlatButton(
                child: new Text('Guardar'),
                onPressed: () {
                  createContactCallback(
                    _contactoNombreController.text,
                    _contactoApellidoController.text,
                    _contactoPhoneController.text,
                  );
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _displayPhotoDialog(BuildContext context) async {
    if (!widget.isMe) {
      return null;
    }
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
                image = File(pickedImage.path);
                setState(() {
                  _profileImage = image.path;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Galeria'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                final pickedImage =
                    await _picker.getImage(source: ImageSource.camera);
                image = File(pickedImage.path);
                setState(() {
                  _profileImage = image.path;
                });
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
                  enabled: widget.isMe,
                  controller: _userNameController,
                  decoration: InputDecoration(hintText: "Nombre"),
                ),
                TextField(
                  enabled: widget.isMe,
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

  Widget _userView(BuildContext context, double width, List<Contact> contacts) {
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
                                image: LocalNetImageProvider(
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
                                enabled: widget.isMe,
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
                                enabled: widget.isMe,
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
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Contactos de emergencia",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => _showAddUser(context),
                          )
                        ],
                      )),
                ),
              ),
            ),
            Container(
              child: SizedBox(
                width: width - 20,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return new UserContactItem(
                      contact: contacts[index],
                      updateCallback: updateContactCallback,
                      deleteCallback: deleteContactCallback,
                    );
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
      appBar: AppBar(title: Text(''), actions: [
        IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              print(_stateUser);
              var user = new User(
                uid: _stateUser.uid,
                name: _userNameController.text,
                lastName: _userLastnameController.text,
                email: _userEmailController.text,
                phone: _userPhoneController.text,
                photo: _stateUser.photo,
              );
              _userBloc.add(UserUpdateEvent(
                user: user,
                profileImage: image,
              ));
            }),
      ]),
      body: BlocProvider(
        create: (context) {
          _userBloc = UserBloc();
          if (widget.isMe) {
            _userBloc.add(UserFetchEvent(uid: _userBloc.client.getUserId()));
          } else {
            _userBloc.add(UserFetchEvent(uid: widget.uid));
          }
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
            _stateUser = state.user;
            _userEmailController.text = state.user.email;
            _userPhoneController.text = state.user.phone;
            _name = state.user.name + " " + state.user.lastName;
            _userNameController.text = state.user.name;
            _userLastnameController.text = state.user.lastName;
            setState(() {
              _profileImage = state.profileImage;
            });
          }
        }, builder: (context, state) {
          if (state is UserFetchedState) {
            return _userView(context, width, state.contacts);
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }),
      ),
    );
  }
}
