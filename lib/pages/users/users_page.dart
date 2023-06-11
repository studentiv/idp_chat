import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idp_chat/models/chat_user.dart';
import 'package:idp_chat/pages/chat/chat_cubit.dart';
import 'package:idp_chat/pages/chat/chat_page.dart';
import 'package:idp_chat/repository/chat_repository.dart';

import 'users_cubit.dart';

class UsersPage extends StatelessWidget {
  const UsersPage();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: BlocBuilder<UsersCubit, UsersState>(
            builder: (context, state) => Column(
              children: [
                ListTile(
                  tileColor: Colors.indigo,
                  title: Text(
                    state.user.userName,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    state.user.email ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                    Icons.account_box,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Users',
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ...state.users.map(
                        (e) => _UserTile(
                          e,
                          () => _toChat(context, state.user, e),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _toChat(
    BuildContext context,
    ChatUser user,
    ChatUser interlocutor,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RepositoryProvider(
            create: (context) => context.read<ChatRepository>(),
            child: BlocProvider(
              create: (_) => ChatCubit(
                ChatState(
                  user: user,
                  interlocutor: interlocutor,
                  chatId: _generateChatId([user.id, interlocutor.id]),
                ),
                context.read<ChatRepository>(),
              ),
              child: ChatPage(),
            ),
          ),
        ),
      );

  String _generateChatId(List<String> usersId) {
    final List<String> sortedIds = usersId..sort();
    return sortedIds.join();
  }
}

class _UserTile extends StatelessWidget {
  final ChatUser user;
  final VoidCallback onTap;

  const _UserTile(this.user, this.onTap);

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        onTap: onTap,
        leading: Icon(Icons.account_circle, size: 60),
        title: Text(user.userName),
      );
}
