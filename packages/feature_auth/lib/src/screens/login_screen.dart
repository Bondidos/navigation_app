import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_api/navigation_api.dart';
import '../bloc/auth_bloc.dart';

abstract class LoginScreen extends StatelessWidget {
  final LoginRouteSpec spec;

  const LoginScreen({
    this.spec = const LoginRouteSpec(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        context.read<INavigation>(),
      ),
      child: const _LoginView(),
    );
  }
}


class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Feature - Login'),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login Screen',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                if (state.isLoading)
                  const CircularProgressIndicator()
                else ...[
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(
                        const LoginPressed(
                          email: 'test@test.com',
                          password: 'password',
                        ),
                      );
                    },
                    child: const Text('Login & Go to Personal'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(GoToPersonalPressed());
                    },
                    child: const Text('Go to Personal (no login)'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}