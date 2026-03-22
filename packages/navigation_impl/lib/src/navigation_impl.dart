import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:navigation_api/navigation_api.dart';
import 'app_router.dart';

class NavigationImpl implements INavigation {
  final AppRouter _appRouter;

  NavigationImpl() : _appRouter = AppRouter();

  /// Возвращает конфигурацию роутера для MaterialApp.router
  /// Включает в себя логгер переходов.
  RouterConfig<Object> get config => _appRouter.config(
        navigatorObservers: () => [_AppNavigationObserver()],
      );

  @override
  void goBack<T extends Object?>([T? result]) {
    _appRouter.maybePop(result);
  }

  @override
  bool get canGoBack => _appRouter.canPop();

  @override
  void popToRoot() {
    _appRouter.popUntilRoot();
  }

  void dispose() {
    _appRouter.dispose();
  }

  @override
  BuildContext? get context => throw UnimplementedError();

  @override
  Future<T?> navigateTo<T extends Object?>(
    RouteSpec destination, {
    bool replace = false,
  }) {
    final PageRouteInfo route = switch (destination) {
      RegisterRouteSpec() => const RegisterRoute(),
      ProfileMainRouteSpec(:final userId) => ProfileMainRoute(userId: userId),
      ProfileSettingsRouteSpec() => const ProfileSettingsRoute(),
      LoginRouteSpec() => const LoginRoute(),
    };

    if (replace) {
      return _appRouter.replace<T>(route);
    } else {
      return _appRouter.push<T>(route);
    }
  }
}

class _AppNavigationObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint('🚀 [NAV] PUSHED: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint('⬅️ [NAV] POPPED: ${route.settings.name}');
  }
}
