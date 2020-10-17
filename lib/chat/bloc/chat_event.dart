part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatInitialEvent extends ChatEvent {
  @override
  List<Object> get props => [];
}

class ImagePickedEvent extends ChatEvent {
  @override
  List<Object> get props => [];
}

class MessageSendEvent extends ChatEvent {
  @override
  List<Object> get props => [];
}
