import 'package:auto_route/auto_route.dart';
import 'package:feature_auth/feature_auth.dart' as auth;

@RoutePage()
class LoginPage extends auth.LoginScreen {
  const LoginPage({
    super.spec,
    super.key,
  });
}
