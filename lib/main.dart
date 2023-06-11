import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idp_chat/pages/login/login_cubit.dart';
import 'package:idp_chat/pages/login/login_page.dart';
import 'package:idp_chat/pages/main/main_cubit.dart';

import 'pages/main/main_page.dart';
import 'pages/splash/splash_page.dart';
import 'pages/users/users_cubit.dart';
import 'repository/auth_repository.dart';
import 'repository/chat_repository.dart';
import 'repository/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: AuthRepository()),
            RepositoryProvider.value(value: UserRepository()),
            RepositoryProvider.value(value: ChatRepository()),
          ],
          child: BlocProvider(
            create: (context) => MainCubit(),
            child: BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                if (state.loading) {
                  return const SplashPage();
                } else if (state.user != null) {
                  return RepositoryProvider(
                    create: (_) => context.read<UserRepository>(),
                    child: BlocProvider(
                      create: (_) => UsersCubit(
                        context.read<UserRepository>(),
                        UsersState(user: state.user!),
                      ),
                      child: MainPage(),
                    ),
                  );
                } else {
                  return BlocProvider(
                    create: (_) => LoginCubit(
                      context.read<AuthRepository>(),
                      context.read<UserRepository>(),
                    ),
                    child: LoginPage(),
                  );
                }
              },
            ),
          ),
        ),
      );
}
