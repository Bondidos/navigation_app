import 'annotations/generate_navigation.dart';

part 'routes.g.dart';

sealed class RouteSpec<T extends Object?> {
  const RouteSpec();
}
//todo will fail codegen if naming is different with autoroute
@GenerateNavigation()
abstract class AppRoutes {
  void login();
  void register();
  void profileMain({required String userId});
  bool? profileSettings();
}
