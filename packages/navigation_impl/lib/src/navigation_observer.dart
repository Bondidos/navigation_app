import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Логгер навигации для отслеживания переходов в консоли.
///
/// Помогает при отладке видеть, какие страницы открываются и закрываются,
/// а также какие аргументы были переданы.
class NavigationLogger extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    _log('🚀 [NAV] PUSHED: ${route.settings.name}', args: route.settings.arguments);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _log('⬅️ [NAV] POPPED: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _log('🔄 [NAV] REPLACED: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}', 
         args: newRoute?.settings.arguments);
  }

  void _log(String message, {Object? args}) {
    debugPrint(message);
    if (args != null) {
      debugPrint('   |_ Args: $args');
    }
  }
}
