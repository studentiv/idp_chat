import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idp_chat/models/chat_user.dart';
import 'package:idp_chat/repository/chat_repository.dart';

part 'users_cubit.freezed.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final ChatRepository chatRepository;

  UsersCubit(this.chatRepository, super.state) {
    getUsers();
  }

  void getUsers() async {
    final users = await chatRepository.getUsers();
    final filteredUsers = users.where((e) => e.id != state.user.id);
    emit(state.copyWith(users: filteredUsers, loading: false));
  }
}
