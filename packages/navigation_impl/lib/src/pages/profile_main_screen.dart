import 'package:auto_route/auto_route.dart';
import 'package:feature_personal/feature_personal.dart' as personal;

@RoutePage()
class ProfileMainScreen extends personal.ProfileMainScreen {
  final String userId;
  const ProfileMainScreen({super.key, required this.userId});
}
