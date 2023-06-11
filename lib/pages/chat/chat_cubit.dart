import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idp_chat/models/chat_user.dart';
import 'package:idp_chat/models/message.dart';
import 'package:idp_chat/repository/chat_repository.dart';

part 'chat_cubit.freezed.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository chatRepository;

  ChatCubit(super.initialState, this.chatRepository) {
    init();
  }

  void init() async {
    await _addChat();
    watchMessage();
  }

  void watchMessage() {
    chatRepository.watchMessages(state.chatId).listen(
      (event) {
        emit(state.copyWith(messages: event));
      },
    );
  }

  Future<void> _addChat() => chatRepository.addChat(state.chatId);

  void addMessage(int time, String text) {
    final message = Message(state.user, time, text);
    chatRepository.addMessage(message, state.chatId);
  }
}
