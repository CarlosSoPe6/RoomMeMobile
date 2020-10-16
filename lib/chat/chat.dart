import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  
  List<ChatMessage> _listMessages = [
    ChatMessage(
        text: "Hello",
        user:  ChatUser(
          name: "Fayeed",
          uid: "123456789",
          avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
        ),
        createdAt: DateTime.now(),
    )
  ];

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat")
      ), 
      body: Container(
        child: DashChat(
          messages: _listMessages, 
          user: ChatUser(
            name: "Jhon Doe",
            uid: "xxxxxxxxx",
            avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
          ),
          dateFormat: DateFormat('dd MMMM yyyy - EEEE'), 
          timeFormat: DateFormat('HH:mm'),
          messageTextBuilder: _createText,
          messageTimeBuilder: _createDate,
          inputContainerStyle: BoxDecoration(border: Border.all(color: Colors.black)),
          messageDecorationBuilder: (message, isUser) {
            return BoxDecoration(
              color: isUser ? Theme.of(context).primaryColor : Colors.grey[300],
              borderRadius: BorderRadius.circular(10)
            );
          },
          onSend: (message) {
            setState(() {
              _listMessages.add(message);
            });
          }
        ),
        
      )
    );
  }

  Widget _createText(String mssg, [ChatMessage]){
    return Text(mssg, style: TextStyle(color: Colors.black));
  }

  Widget _createDate(String mssg, [ChatMessage]){
    return Text(mssg, style: TextStyle(color: Colors.black, fontSize: 10));
  }
}