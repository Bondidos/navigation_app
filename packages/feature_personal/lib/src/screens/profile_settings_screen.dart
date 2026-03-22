import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_api/navigation_api.dart';

import '../../feature_personal.dart';

abstract class ProfileSettingsScreen extends StatelessWidget {
  final ProfileSettingsRouteSpec spec;

  const ProfileSettingsScreen({required this.spec, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(context.read<INavigation>()),
      child: const _ProfileSettingsView(),
    );
  }
}

class _ProfileSettingsView extends StatelessWidget {
  const _ProfileSettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Feature - Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Settings Screen', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
