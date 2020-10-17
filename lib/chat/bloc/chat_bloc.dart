import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if(event is ChatInitialEvent) {
      yield ChatInitial();
    }
    else if(event is ImagePickedEvent){
      yield ImagePickedState();
    }else if(event is MessageSendEvent) {
      yield ChatInitial();
    }
  }
}
