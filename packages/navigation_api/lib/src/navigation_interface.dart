import 'package:flutter/widgets.dart';
import '../navigation_api.dart';

abstract interface class INavigation {
  /// Навигация на основе спецификации маршрута
  Future<T?> navigateTo<T extends Object?>(
        RouteSpec destination, {
        bool replace = false,
      });

  /// Возврат с результатом
  void goBack<T extends Object?>([T? result]);

  /// Проверка возможности возврата
  bool get canGoBack;

  /// Очистка стека до корня
  void popToRoot();

  /// Контекст для показа диалогов и т.д.
  BuildContext? get context;
}