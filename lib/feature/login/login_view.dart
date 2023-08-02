import 'package:flutter/material.dart';
import 'package:flutter_firebase/feature/login/login_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final loginProvider = StateNotifierProvider<LoginProvider, int>((ref) {
    return LoginProvider();
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Firebase App')),
      body: Center(
        child: Column(
          children: [
            Text(
              'text',
              style: TextStyle(color: Colors.amber),
            ),
            Text(ref.watch(loginProvider).toString()),
          ],
        ),
      ),
    );
  }
}
