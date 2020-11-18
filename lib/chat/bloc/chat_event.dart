part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetMessagesEvent extends ChatEvent {
  @override
  List<Object> get props => [];
}

class DeleteImageEvent extends ChatEvent {
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

class MessageReceivedEvent extends ChatEvent {
  final ChatMessage chatMessage;

  MessageReceivedEvent({@required this.chatMessage});

  @override
  List<Object> get props => [chatMessage];
}
