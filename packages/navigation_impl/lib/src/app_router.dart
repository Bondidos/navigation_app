import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:navigation_api/navigation_api.dart';
import 'pages/login_screen.dart';
import 'pages/register_screen.dart';
import 'pages/profile_main_screen.dart';
import 'pages/profile_settings_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    // Auth Feature
    AutoRoute(
      path: '/auth/login',
      page: LoginRoute.page,
      initial: true,
    ),
    AutoRoute(
      path: '/auth/register',
      page: RegisterRoute.page,
    ),

    // Personal Feature
    AutoRoute(
      path: '/profile/main',
      page: ProfileMainRoute.page,
    ),
    AutoRoute(
      path: '/profile/settings',
      page: ProfileSettingsRoute.page,
    ),
  ];
}