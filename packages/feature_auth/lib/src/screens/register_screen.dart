import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_api/navigation_api.dart';

import '../../feature_auth.dart';

abstract class RegisterScreen extends StatelessWidget {
  final RegisterRouteSpec spec;

  const RegisterScreen({
    required this.spec,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        context.read<INavigation>(),
      ),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Feature - Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Register Screen',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                bloc.add(
                  const RegisterPressed(
                    email: 'new@user.com',
                    password: 'password',
                  ),
                );
              },
              child: const Text('Register & Go to Personal'),
            ),
          ],
        ),
      ),
    );
  }
}