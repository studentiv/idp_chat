part of 'main_cubit.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default(true) bool loading,
    bool? isAuthorized,
    ChatUser? user,
  }) = _MainState;
}
