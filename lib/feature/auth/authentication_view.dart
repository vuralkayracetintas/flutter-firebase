import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/feature/auth/authentication_provider.dart';
import 'package:flutter_firebase/product/constans/index.dart';
import 'package:flutter_firebase/product/widgets/text/title_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {
  final authProvider =
      StateNotifierProvider<AuthenticationNotifier, AuthenticationState>((ref) {
    return AuthenticationNotifier();
  });
  @override
  void initState() {
    super.initState();
    checkUser(FirebaseAuth.instance.currentUser);
  }

  void checkUser(User? user) {
    ref.read(authProvider.notifier).fetchUserDetails(user!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: context.padding.normal,
            child: Column(
              children: [
                _header(context),
                const SizedBox(
                  height: 10,
                ),
                firebase.FirebaseUIActions(
                  actions: [
                    AuthStateChangeAction<SignedIn>((context, state) {
                      if (state.user != null) {
                        checkUser(state.user);
                      } else {
                        Navigator.pushReplacementNamed(context, '/profile');
                      }
                    }),
                  ],
                  child: firebase.LoginView(
                    action: AuthAction.signIn,
                    providers: firebase.FirebaseUIAuth.providersFor(
                      FirebaseAuth.instance.app,
                    ),
                  ),
                ),
                if (ref.watch(authProvider).isRedirect)
                  // continue to app button
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      StringConstants.loginContinueApp,
                      style: context.general.textTheme.bodySmall
                          ?.copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _header(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          value: StringConstants.loginWelcomeBack,
        ),
        TitleText(
          value: StringConstants.loginWelcomeDetails,
        ),
      ],
    );
  }
}
