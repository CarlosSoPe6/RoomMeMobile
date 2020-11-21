import 'package:RoomMeMobile/models/contact.dart';
import 'package:flutter/material.dart';

class UserContactItem extends StatelessWidget {
  final Contact contact;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final Function(Contact, String, String, String) updateCallback;

  UserContactItem({@required this.contact, @required this.updateCallback}) {
    _nombreController.text = contact.name;
    _apellidoController.text = contact.lastName;
    _phoneController.text = contact.phone;
  }

  void _showDialog(BuildContext context) async {
    return await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Editar contacto'),
            content: Column(
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: InputDecoration(hintText: "Nombre"),
                ),
                TextField(
                  controller: _apellidoController,
                  decoration: InputDecoration(hintText: "Apellido"),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(hintText: "Teléfono"),
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Guardar'),
                onPressed: () {
                  updateCallback(
                    this.contact,
                    _nombreController.text,
                    _apellidoController.text,
                    _phoneController.text,
                  );
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  "${this.contact.name} ${this.contact.lastName}",
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  this.contact.phone,
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        ),
      ),
      onLongPress: () => _showDialog(context),
    );
  }
}
