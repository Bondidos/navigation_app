import 'package:auto_route/annotations.dart';
import 'package:feature_auth/feature_auth.dart' as auth;

@RoutePage()
class RegisterScreen extends auth.RegisterScreen {
  const RegisterScreen({required super.spec, super.key});
}
