import 'dart:async';

import 'package:RoomMeMobile/http/client.dart';
import 'package:bloc/bloc.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as net;

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final String _link = 'https://room-me-app.herokuapp.com/api/chat/';
  final String _me = 'https://room-me-app.herokuapp.com/user/me';
  List<ChatMessage> _listMessages = [];
  List<String> _invalidAvatars = [];
  ChatBloc() : super(ChatInit());
  List <ChatMessage> get getChatMessages => _listMessages;
  ChatUser _chatUser;
  ChatUser get getChatUser => _chatUser;
  String house;
  Future<bool> _chatReady;
  Future<bool> get isReady => _chatReady;

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if(event is ChatInitEvent){
     
      this.house = event.houseId.toString();
      await  _checkChatUsers(event.houseId.toString());
      
      yield ChatReady();
    }
    else if(event is GetMessagesEvent) {
      print("Chat iniciado");
      yield MessagesLoadingState();
      await _getMessages(this.house);
      await _getUser();
      yield ChatFetched();
    }
    else if(event is ImagePickedEvent){
      yield ImagePickedState();
    }else if(event is MessageSendEvent) {
      yield ChatIdle();
    }else if(event is DeleteImageEvent) {
      yield ChatIdle();
    }else if(event is MessageReceivedEvent) {
      yield MessagesFetchingState();
      _listMessages.add(event.chatMessage);
      print("Received");
      yield ChatIdle();
    }
  }

  _getMessages(String houseId) async{
    
    print(_invalidAvatars);
    try{
      HttpClient c = HttpClient.getClient();
      List<dynamic> response =  await c.get(_link + houseId, null);
      _listMessages =  response.map( (element)  {
        String imageUrl = "https://room-me-app.herokuapp.com/user/${element['authorId']}/image";
        print("Checando Avatares");
        if(_invalidAvatars.contains(element['authorId'].toString())){
          imageUrl = null;
        }
          return ChatMessage(
            text: element['message'],
            createdAt: DateTime.parse(element['time']).toLocal(),
            user: ChatUser(
              name: element['authorName'].toString(),
              uid: element['authorId'].toString(),
              avatar: imageUrl
            )
          );
        }
      ).toList();
    }catch(e){
      print(e);
    }
    
  }

  _checkChatUsers(String houseId) async {
    HttpClient c = HttpClient.getClient();
    String _link = "https://room-me-app.herokuapp.com/house/${houseId}";
    
    dynamic response = await c.get(_link, null);
    for(var member in response['members']) {
      String imageLink = "https://room-me-app.herokuapp.com/user/${member}/image";
      net.Response responseImage =  await net.get(imageLink);
      if(responseImage.statusCode != 200){
        _invalidAvatars.add(member.toString());
        print("Invalid Avatar");
        print(_invalidAvatars);
      }
    }
  }

  _getUser() async {
    try{
      HttpClient c = HttpClient.getClient();
      dynamic response =  await c.get(_me, null);
      _chatUser =  ChatUser(
        name: response['name'],
        uid: response['uid'].toString()
      );
        
    }catch(e){
      print(e);
    }
  }
}
