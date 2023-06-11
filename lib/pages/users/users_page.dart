import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idp_chat/models/chat_user.dart';

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
                  //height: 30,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Users', style: TextStyle(fontSize: 20),)),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ...state.users.map(_UserTile.new),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _UserTile extends StatelessWidget {
  final ChatUser user;

  const _UserTile(this.user);

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        onTap: () {},
        leading: Icon(Icons.account_circle, size: 60),
        title: Text(user.userName),
      );
}
