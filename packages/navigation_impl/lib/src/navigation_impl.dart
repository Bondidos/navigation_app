import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:navigation_api/navigation_api.dart';
import 'app_router.dart';
import 'navigation_observer.dart';

/// Тип функции для маппинга [RouteSpec] в [PageRouteInfo] (AutoRoute).
typedef RouteMapperFunc = PageRouteInfo Function(RouteSpec destination);

/// Реализация интерфейса навигации на базе AutoRoute.
class NavigationImpl implements INavigation {
  final AppRouter _appRouter;
  final RouteMapperFunc _mapper;

  /// Конструктор принимает [mapper] — функцию, которая знает, как
  /// превратить универсальный [RouteSpec] в специфичный для AutoRoute роут.
  NavigationImpl({
    required RouteMapperFunc mapper,
    AppRouter? appRouter,
  })  : _mapper = mapper,
        _appRouter = appRouter ?? AppRouter();

  RouterConfig<Object> get config => _appRouter.config(
        navigatorObservers: () => [NavigationLogger()],
      );

  @override
  Future<T?> navigateTo<T extends Object?>(RouteSpec<T> destination) {
    return _appRouter.push<T>(_mapper(destination));
  }

  @override
  Future<void> pop<T extends Object?>([T? result]) async {
    await _appRouter.maybePop<T>(result);
  }

  @override
  Future<T?> replaceWith<T extends Object?>(RouteSpec<T> destination) {
    return _appRouter.replace<T>(_mapper(destination));
  }

  @override
  void popToRoot() {
    _appRouter.popUntilRoot();
  }

  @override
  Future<T?> clearStackAndNavigateTo<T extends Object?>(RouteSpec<T> destination) {
    return _appRouter.pushAndPopUntil<T>(
      _mapper(destination),
      predicate: (route) => false,
    );
  }

  void dispose() {
    _appRouter.dispose();
  }

  BuildContext? get context => _appRouter.navigatorKey.currentContext;
}
