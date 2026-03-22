sealed class RouteSpec {
  const RouteSpec();
}

class RegisterRouteSpec extends RouteSpec {
  const RegisterRouteSpec();
}

class ProfileMainRouteSpec extends RouteSpec {
  final String userId;
  const ProfileMainRouteSpec({required this.userId});
}

class ProfileSettingsRouteSpec extends RouteSpec {
  const ProfileSettingsRouteSpec();
}

class LoginRouteSpec extends RouteSpec {
  const LoginRouteSpec();
}
