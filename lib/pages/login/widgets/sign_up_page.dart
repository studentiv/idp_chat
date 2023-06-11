import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idp_chat/models/chat_user.dart';
import 'package:idp_chat/pages/login/login_cubit.dart';
import 'package:idp_chat/pages/main/main_cubit.dart';

import 'widget.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback onPageChange;
  final String? errorText;

  const SignUpPage(this.onPageChange, this.errorText);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email = '';
  String _password = '';
  String _userName = '';

  @override
  Widget build(BuildContext context) => Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Logo(),
                const SizedBox(height: 50),
                Form(
                  child: Column(
                    children: [
                      DefaultTextField(_onNicknameChange, 'Nickname'),
                      const SizedBox(height: 20),
                      DefaultTextField(_onEmailChange, 'Email'),
                      const SizedBox(height: 20),
                      PasswordField(_onPasswordChange),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                if (widget.errorText != null)
                  Text(
                    widget.errorText!,
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
                const SizedBox(height: 10),
                SignButton(
                  'Sign Up',
                  () => context
                      .read<LoginCubit>()
                      .signUpWithEmailAndPassword(_email, _password, _userName),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'or',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 15),
                FacebookLabel(
                  'Sign Up with Facebook',
                  () => context.read<LoginCubit>().signInWithFacebook(),
                ),
                const SizedBox(height: 15),
                GoogleLabel(
                  'Sign Up with Google',
                  () => context.read<LoginCubit>().signInWithGoogle(),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: widget.onPageChange,
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );

  void _onEmailChange(String email) => _email = email;

  void _onPasswordChange(String password) => _password = password;

  void _onNicknameChange(String nickname) => _userName = nickname;

  void signUp(Future<ChatUser?> authMethod) async {
    final user = await authMethod;

    if (user != null) {
      context.read<MainCubit>().setUser(user);
    }
  }
}
