import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_api/navigation_api.dart';
import '../bloc/profile_bloc.dart';

abstract class ProfileMainScreen extends StatelessWidget {
  final ProfileMainRouteSpec spec;

  const ProfileMainScreen({
    required this.spec,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(context.read<INavigation>()),
      child: const _ProfileMainView(),
    );
  }
}

class _ProfileMainView extends StatelessWidget {
  const _ProfileMainView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Personal Feature - Main')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome, ${state.userName}!',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Profile Main Screen',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                if (state.isLoading)
                  const CircularProgressIndicator()
                else ...[
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(OpenSettingsPressed());
                    },
                    child: const Text('Open Settings (same feature)'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(GoToAuthPressed());
                    },
                    child: const Text('Go to Auth (other feature)'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(LogoutPressed());
                    },
                    child: const Text('Logout & Go to Auth'),
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
