part of 'chat_cubit.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    required ChatUser user,
    required ChatUser interlocutor,
    required String chatId,
    @Default(true) bool loading,
    @Default([]) List<Message> messages,
  }) = _ChatState;
}
