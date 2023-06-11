import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idp_chat/models/chat_user.dart';
import 'package:idp_chat/repository/auth_repository.dart';
import 'package:idp_chat/repository/chat_repository.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  final ChatRepository chatRepository;

  LoginCubit(this.authRepository, this.chatRepository) : super(LoginState());

  Future<ChatUser?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    User? user;
    String? error;
    emit(state.copyWith(loading: true));
    final result = await authRepository.signInWithEmailAndPassword(
      email,
      password,
    );
    result.fold((left) => user = left, (right) => error = right);
    if (user != null) {
      return await chatRepository.getUser(user!);
    }
    emit(state.copyWith(loading: false, errorText: error));
    return null;
  }

  Future<ChatUser?> signUpWithEmailAndPassword(
    String email,
    String password,
    String userName,
  ) async {
    User? user;
    String? error;
    emit(state.copyWith(loading: true));
    final result = await authRepository.signUpWithEmailAndPassword(
      email,
      password,
    );
    result.fold(
      (left) => user = left,
      (right) => error = right,
    );

    if (user != null) {
      final chatUser = ChatUser(
        email: email,
        id: user!.uid,
        userName: userName,
      );
      await chatRepository.addUser(chatUser);
      return chatUser;
    }

    emit(state.copyWith(loading: false, errorText: error));
    return null;
  }

  Future<ChatUser?> signInWithGoogle() async {
    emit(state.copyWith(loading: true));
    final user = await authRepository.signInWithGoogle();
    if (user != null) {
      return await chatRepository.getUser(user);
    }
    emit(state.copyWith(loading: false));
    return null;
  }

  Future<ChatUser?> signInWithFacebook() async {
    emit(state.copyWith(loading: true));
    final result = await authRepository.signInWithFacebook();
    User? user;
    String? error;
    result.fold(
      (left) => user = left,
      (right) => error = right,
    );
    if (user != null) {
      return await chatRepository.getUser(user!);
    }
    emit(state.copyWith(errorText: error, loading: false));
    return null;
  }
}
