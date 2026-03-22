import 'package:auto_route/auto_route.dart';
import 'package:feature_personal/feature_personal.dart' as personal;

@RoutePage()
class ProfileSettingsPage extends personal.ProfileSettingsScreen {
  const ProfileSettingsPage({
    required super.spec,
    super.key,
  });
}
