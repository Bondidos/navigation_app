import '../navigation_api.dart';

/// Интерфейс системы навигации, который используется в BLoC/ViewModel.
///
/// Позволяет фичам переходить на другие экраны, не зная о деталях реализации
/// и конкретных библиотеках навигации.
abstract interface class INavigation {
  /// Основной метод перехода на новый экран.
  ///
  /// Принимает объект [RouteSpec], сгенерированный на основе AppRoutes.
  /// Возвращает [Future], который завершается результатом перехода (если он есть).
  Future<T?> navigateTo<T extends Object?>(RouteSpec<T> destination);

  /// Возврат на предыдущий экран.
  ///
  /// Может возвращать [result] вызвавшему экрану.
  Future<void> pop<T extends Object?>([T? result]);

  /// Заменяет текущий стек навигации новым экраном.
  Future<T?> replaceWith<T extends Object?>(RouteSpec<T> destination);

  /// Очистка стека до корня
  void popToRoot();

  /// Очищает весь стек и делает указанный экран корневым.
  Future<T?> clearStackAndNavigateTo<T extends Object?>(RouteSpec<T> destination);
}
