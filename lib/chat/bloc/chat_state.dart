part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

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
