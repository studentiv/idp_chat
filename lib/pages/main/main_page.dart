import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idp_chat/pages/main/main_cubit.dart';
import 'package:idp_chat/pages/users/users_page.dart';

class MainPage extends StatefulWidget {
  const MainPage();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  late final List<Widget> tabs = [
    Center(child: UsersPage()),
    Center(child: ElevatedButton(onPressed: logout, child: Text('logout'))),
  ];

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: tabs[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Users'),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_sharp),
                label: 'Account',
              ),
            ],
          ),
        ),
      );

  void logout() {
    context.read<MainCubit>().logout();
  }
}
