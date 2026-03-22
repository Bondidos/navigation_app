import 'annotations/generate_navigation.dart';

part 'routes.g.dart';

sealed class RouteSpec<T extends Object?> {
  const RouteSpec();
}

@GenerateNavigation()
abstract class AppRoutes {
}
