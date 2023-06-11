part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(true) bool loading,
    String? errorText,
  }) = _LoginState;
}
