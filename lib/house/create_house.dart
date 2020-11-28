import 'dart:io';

import 'package:RoomMeMobile/house/bloc/house_bloc.dart';
import 'package:RoomMeMobile/utils/custom_search_delegate.dart';
import 'package:RoomMeMobile/models/house.dart';
import 'package:RoomMeMobile/utils/LocalNetImageProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Product { Galeria, Camara }

class CreateHouse extends StatefulWidget {
  final House house;
  CreateHouse({@required this.house});
  @override
  _CreateHouseState createState() => _CreateHouseState();
}

class _CreateHouseState extends State<CreateHouse> {
  HouseBloc _houseBloc;
  File image;
  String imageURL;
  final _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _localidadController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _habitantesController = TextEditingController();
  final TextEditingController _costoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    imageURL =
        "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimg1.cgtrader.com%2Fitems%2F826675%2F229135006e%2Fempty-room-3d-model-blend.jpg&f=1&nofb=1";
    _titleController.text = '';
    _costoController.text = '';
    _descriptionController.text = '';
    _direccionController.text = '';
    _habitantesController.text = '';
    _localidadController.text = '';
    _zipController.text = '';
    _tipoController.text = '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _direccionController.dispose();
    _localidadController.dispose();
    _zipController.dispose();
    _tipoController.dispose();
    _habitantesController.dispose();
    _costoController.dispose();
    _houseBloc.close();
    super.dispose();
  }

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
                image = File(pickedImage.path);
                setState(() {
                  imageURL = image.path;
                });
                _houseBloc.add(HouseUpdateFotoEvent(file: image));
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
                  imageURL = image.path;
                });
                _houseBloc.add(HouseUpdateFotoEvent(file: image));
                Navigator.of(context).pop();
              },
              child: const Text('Cámara'),
            ),
          ],
        );
      },
    );
  }

  Widget _houseView(BuildContext context, double width) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _displayPhotoDialog(context);
              },
              child: ClipRRect(
                child: Image(
                  fit: BoxFit.fill,
                  image: LocalNetImageProvider(imageURL),
                  width: width,
                  height: 150,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width - 20,
                          child: Text(
                            "Tituo",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: width - 20,
                          child: TextField(
                            controller: _titleController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: _descriptionController,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width - 20,
                          child: Text(
                            "Dirección",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: width - 20,
                          child: TextField(
                            controller: _direccionController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width - 20,
                          child: Text(
                            "Localidad",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: width - 20,
                          child: TextField(
                            controller: _localidadController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: (width - 20) * 0.33,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "C.P",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextField(
                                controller: _zipController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: (width - 20) * 0.66,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tipo",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextField(
                                controller: _tipoController,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: (width - 20) * 0.33,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Habitantes",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextField(
                                controller: _habitantesController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: (width - 20) * 0.66,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Costo",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextField(
                                controller: _costoController,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edición"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
                icon: Icon(Icons.group_add),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate:
                          CustomSearchDelegate(listUsers: _houseBloc.getUsers));
                }),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                int hid = widget.house == null ? 0 : widget.house.hid;
                House house = new House(
                  hid: hid,
                  services: widget.house == null ? [] : widget.house.services,
                  title: _titleController.text,
                  type: _tipoController.text,
                  description: _descriptionController.text,
                  // ownerId,
                  addressLine: _direccionController.text,
                  zipCode: _zipController.text,
                  city: _localidadController.text,
                  state: '',
                  country: '',
                  cost: int.parse(_costoController.text),
                  roommatesLimit: int.parse(_habitantesController.text),
                  roommatesCount:
                      widget.house == null ? 0 : widget.house.roommatesCount,
                  playlistUrl: '',
                  foto: imageURL,
                );
                bool isNew = widget.house == null;
                _houseBloc.add(HouseSaveEvent(
                  house: house,
                  isNew: isNew,
                ));
              },
              child: Icon(
                Icons.save,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          _houseBloc = HouseBloc();
          if (widget.house == null) {
            _houseBloc.add(HouseCreateEvent());
          } else {
            _houseBloc.add(HouseFetchEvent(hid: widget.house.hid));
          }
          return _houseBloc;
        },
        child: BlocConsumer<HouseBloc, HouseState>(
          listener: (context, state) {
            if (state is HouseErrorState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text("Error: ${state.error}")),
                );
            } else if (state is HouseFetchedState) {
              setState(() {
                imageURL = state.house.foto;
                _titleController.text = state.house.title;
                _costoController.text = state.house.cost.toString();
                _descriptionController.text = state.house.description;
                _direccionController.text = state.house.addressLine;
                _habitantesController.text =
                    state.house.roommatesLimit.toString();
                _localidadController.text = state.house.city;
                _zipController.text = state.house.zipCode;
                _tipoController.text = state.house.type;
              });
            } else if (state is HouseCreateEvent) {
              setState(() {
                imageURL =
                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimg1.cgtrader.com%2Fitems%2F826675%2F229135006e%2Fempty-room-3d-model-blend.jpg&f=1&nofb=1";
              });
            }
            if (state is HomeActionSuccess) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is HouseFetchedState) {
              return _houseView(context, width);
            }
            if (state is HouseCreateState) {
              return _houseView(context, width);
            }
            return Container(
                // child: Center(
                //   child: CircularProgressIndicator(),
                // ),
                );
          },
        ),
      ),
    );
  }
}
