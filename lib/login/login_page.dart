import 'package:RoomMeMobile/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color iconColor = Colors.grey;

  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio de Sesión"),
        
      ),
      body: SingleChildScrollView(
          child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(70.0),
              child: Container(
                child: Text("RoomMe", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),)
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField( 
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Password",
                  suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                            if(obscureText) {
                              iconColor = Colors.grey;
                            }else {
                              iconColor = Colors.black;
                            }
                          });
                        },
                        icon: Icon(Icons.remove_red_eye, color: iconColor)
                      )  
                    ),
                obscureText: obscureText,
              ),
                
                
              ),
            
            SizedBox(height: 80,),
            RaisedButton(
              child: Text("INICIAR SESIÓN"),
              color: Color(0xFFFEDCD2),
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Chat())
                );
              }
            ),
            SizedBox(height: 30,),
            Text("Crear una cuenta", style: TextStyle(color: Colors.lightBlue, decoration: TextDecoration.underline),)
          ]
        ),
      ),
    );
  }
}