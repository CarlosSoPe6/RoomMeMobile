import 'dart:async';

import 'package:RoomMeMobile/http/client.dart';
import 'package:bloc/bloc.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as net;

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final String _link = 'https://room-me-app.herokuapp.com/api/chat/27';
  final String _me = 'https://room-me-app.herokuapp.com/user/me';
  List<ChatMessage> _listMessages = [];
  ChatBloc() : super(ChatInit());
  List <ChatMessage> get getChatMessages => _listMessages;
  ChatUser _chatUser;
  ChatUser get getChatUser => _chatUser;

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if(event is GetMessagesEvent) {
      print("Chat iniciado");
      yield MessagesLoadingState();
      await _getMessages();
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
      yield MessagesLoadingState();
      _listMessages.add(event.chatMessage);
      print("Received");
      yield ChatIdle();
    }
  }

  _getMessages() async{
    try{
      HttpClient c = HttpClient.getClient();
      List<dynamic> response =  await c.get(_link, null);
      _listMessages = response.map((element) => ChatMessage(
        text: element['message'],
        createdAt: DateTime.parse(element['time']).toLocal(),
        user: ChatUser(
          name: element['authorName'].toString(),
          uid: element['authorId'].toString(),
          avatar: "https://room-me-app.herokuapp.com/user/${element['authorId']}/image"
        )
      )).toList();
    }catch(e){
      print(e);
    }
  }

  _getUser() async {
    try{
      HttpClient c = HttpClient.getClient();
      dynamic response =  await c.get(_me, null);
      _chatUser =  ChatUser(
        name: response['name'],
        avatar: response['photo'],
        uid: response['uid'].toString()
      );
        
    }catch(e){
      print(e);
    }
  }
}
