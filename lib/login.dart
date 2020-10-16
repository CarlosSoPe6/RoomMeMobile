import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                  child: Text('Ingresa'),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/house/detail')),
              Text('Hello World'),
              GestureDetector(
                child: Text('Crea una cuenta',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline)),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/register');
                },
              )
            ]),
      ),
    );
  }
}
