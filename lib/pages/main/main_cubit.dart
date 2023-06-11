import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idp_chat/models/chat_user.dart';
import 'package:idp_chat/repository/auth_repository.dart';
import 'package:idp_chat/repository/user_repository.dart';

part 'main_cubit.freezed.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final AuthRepository authRepository = AuthRepository();
  final UserRepository chatRepository = UserRepository();

  MainCubit() : super(MainState()) {
    _initial();
  }

  void _initial() async {
    await _checkAuthStatus();
    await getUser();
  }

  Future<void> _checkAuthStatus() async {
    final isAuthorized = await authRepository.checkAuthStatus();
    emit(state.copyWith(loading: false, isAuthorized: isAuthorized));
  }

  Future<void> getUser() async {
    final user = authRepository.getCurrentUser();
    if (user != null) {
      final chatUser = await chatRepository.getUser(user);
      if (chatUser != null) {
        setUser(chatUser);
      }
    }
    return null;
  }

  void setUser(ChatUser user) => emit(state.copyWith(user: user));

  void logout() async {
    await authRepository.signOut();
    emit(state.copyWith(isAuthorized: false, user: null));
  }
}
