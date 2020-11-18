import 'dart:io';

import 'package:RoomMeMobile/chat/bloc/chat_bloc.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Chat extends StatefulWidget {
  
  Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _picker = ImagePicker();
  String _image;
  ChatBloc _chatBloc;
  Socket _socketIO;
  List<ChatMessage> _listMessages = [];

  @override
  void initState() {
    _connectSocket();
    super.initState();
  }

  @override
  void dispose() {
    _chatBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat")
      ), 
      body: BlocProvider(
        create: (context) {
          _chatBloc = ChatBloc();
          return _chatBloc..add(GetMessagesEvent());
        },
        child: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {
            
            
          },
          builder: (context, state) {
            return Container(
                  child: DashChat(
                    showAvatarForEveryMessage: true,
                    messages: _chatBloc.getChatMessages, 
                    user: ChatUser(
                      name: "Jhon Doe",
                      uid: "10000",
                      avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
                    ),
                    dateFormat: DateFormat('dd MMMM yyyy - EEEE'), 
                    timeFormat: DateFormat('HH:mm'),
                    trailing: [
                      IconButton(
                        icon: Icon(Icons.photo, color: Colors.grey,), 
                        onPressed: () async{
                          final pickedImage = await _picker.getImage(source: ImageSource.gallery);
                          if(pickedImage != null) {
                            _image = pickedImage.path;
                            _chatBloc.add(ImagePickedEvent());
                          }
                         
                        }
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.grey,), 
                        onPressed: () async{
                          final pickedImage = await _picker.getImage(source: ImageSource.camera);
                          if(pickedImage != null) {
                            _image = pickedImage.path;
                            _chatBloc.add(ImagePickedEvent());
                          }
                         
                        }
                      )
                    ],
                    messageTextBuilder: _createText,
                    messageTimeBuilder: _createDate,
                    messageImageBuilder: _createImage,
                    textBeforeImage: false,
                    inputContainerStyle: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor, width: 5.0),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    messageDecorationBuilder: (message, isUser) {
                      return BoxDecoration(
                        color: isUser ? Theme.of(context).primaryColor : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)
                      );
                    },
                    chatFooterBuilder: state is ImagePickedState ? _footerImage : null,
                    onSend: (message) {
                      if(_image != null) message.image = _image;
                      _emitSocketMessage(message);
                      
                      _image = null;
                      _chatBloc.add(MessageSendEvent());
                    }
                  ),    
            );
          },
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

  Widget _createImage(String image, [ChatMessage]){
    return Image.file(File(image), );
  }

  Widget _footerImage(){
    return Container(
      
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.file(File(_image), height: 50,),
                Text("Imagen Seleccionada"),
              ]
            ),
            Positioned(
                right: 1,
                child: IconButton(
                  icon: Icon(Icons.delete), 
                  onPressed: (){
                    _image = null;
                    _chatBloc.add(DeleteImageEvent()); //TODO: Modify later
                  }
                )
            )
          ]
          ),
        ),
      );
    
  }

  _connectSocket(){
    _socketIO = io('https://room-me-app.herokuapp.com', <String, dynamic>{
      'transports':['websocket'],
      'autoConnect':false
    });
    _socketIO.connect();
    _socketIO.emit('entrar','27');

    _socketIO.on('chatear', (receivedChat) {
      _chatBloc.add(MessageReceivedEvent(chatMessage:
        ChatMessage(
          text: receivedChat['message'],
          createdAt: DateTime.parse(receivedChat['time']).toLocal(),
          user: ChatUser(
            name: receivedChat['authorName'].toString(),
            uid: receivedChat['authorId'].toString(),
            avatar: "https://room-me-app.herokuapp.com/user/${receivedChat['authorId']}/image"
          )
        )
      ));     
    });
  }

  _emitSocketMessage(ChatMessage chatMessage) {
    _socketIO.emit('chatear', {
      'user': chatMessage.user.uid,
      'house': 27,
      'msg': chatMessage.text,
      'time': chatMessage.createdAt.toIso8601String()
    });
  }
}