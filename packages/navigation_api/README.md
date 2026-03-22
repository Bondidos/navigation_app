# Navigation API

Пакет для описания навигационных контрактов в Flutter-приложениях.
Позволяет отвязать бизнес-логику (BLoC/ViewModel) от конкретной реализации навигации (Navigator 2.0, AutoRoute).

## Установка в новом проекте

1. Скопируйте папку `navigation_api` в свой проект.
2. В основном проекте или модуле навигации создайте файл `app_routes.dart`:
```dart
import 'package:navigation_api/navigation_api.dart';
part 'app_routes.g.dart';

@GenerateNavigation() 
abstract class AppRoutes { 
  /// Добавляйте сюда методы-маршруты: 
  void login(); void profile({required String userId}); 
} 
```
3. Запустите генерацию: `dart run build_runner build`.
   Это создаст классы `LoginRouteSpec` и `ProfileRouteSpec`.

## Интерфейс INavigation

Используйте `INavigation` в своих BLoC:

```dart
  final INavigation _navigation;

  void execute() {
    _navigation.navigateTo(ProfileSettingsRouteSpec());
  }
```