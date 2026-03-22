import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:navigation_impl/navigation_impl.dart';
import 'package:navigation_api/navigation_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final NavigationImpl _navigationImpl;

  @override
  void initState() {
    super.initState();
    _navigationImpl = NavigationImpl();
  }

  @override
  void dispose() {
    _navigationImpl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<INavigation>.value(
      value: _navigationImpl,
      child: MaterialApp.router(
        title: 'Navigation MVP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: _navigationImpl.config,
        builder: (context, child) {
          return child ?? const SizedBox.shrink();
        },
      ),
    );
  }
}
