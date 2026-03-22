# Navigation Implementation

Универсальная реализация системы навигации на базе **AutoRoute**.

## Как подключить в новый проект

1. Создайте свой `AppRouter` (наследник`RootStackRouter`).
2. Для связи Spec-объектов с экранами используйте `@GenerateMapper`:
```dart
@GenerateMapper(AppRoutes)
class _RouteMapperTrigger {
  ///код сгенурируется в .g.dart
}
```
3. В реализации `INavigation` (NavigationImpl) прокиньте свой `AppRouter` и вызовите `RouteMapper.map(destination)`.

## Особенности
Пакет содержит `MapperGenerator`, который автоматически находит ваши страницы в проекте.
Страница должна:
1. Быть помечена `@RoutePage()`.
2. Иметь в конструкторе параметр `spec` соответствующего типа.