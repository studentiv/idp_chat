import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idp_chat/pages/login/login_cubit.dart';

import 'widgets/sign_in_page.dart';
import 'widgets/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) => PageView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: controller,
              children: [
                SignInPage(onPageChange, state.errorText, state.loading),
                SignUpPage(onPageChange, state.errorText, state.loading)
              ],
            ),
          ),
        ),
      );

  void onPageChange() {
    final currentPageIndex = controller.page?.round();
    if (currentPageIndex != null) {
      controller.animateToPage(
        currentPageIndex == 0 ? 1 : 0,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeOutQuad,
      );
    }
  }
}
