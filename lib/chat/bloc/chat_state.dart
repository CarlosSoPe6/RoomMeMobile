part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}



class ChatInit extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatReady extends ChatState {
  @override
  List<Object> get props => [];
}

class PreparingChatState extends ChatState {
  @override
  List<Object> get props => [];
}

class CheckingChatState extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatFetched extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatIdle extends ChatState {
  @override
  List<Object> get props => [];
}

class ImagePickedState extends ChatState {
  @override
  List<Object> get props => [];
}

class MessagesLoadingState extends ChatState {
  
  @override
  List<Object> get props => [];
}

class MessagesFetchingState extends ChatState {
  
  @override
  List<Object> get props => [];
}
