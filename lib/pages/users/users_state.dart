part of 'users_cubit.dart';

@freezed
class UsersState with _$UsersState {
  const factory UsersState({
    required ChatUser user,
    @Default([]) Iterable<ChatUser> users,
    @Default(true) bool loading,
  }) = _UsersState;
}
