import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navigation_api/navigation_api.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final INavigation _navigation;

  AuthBloc(this._navigation) : super(const AuthState()) {
    on<LoginPressed>(_onLoginPressed);
    on<RegisterPressed>(_onRegisterPressed);
    on<GoToPersonalPressed>(_onGoToPersonalPressed);
  }

  Future<void> _onLoginPressed(
    LoginPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    await _navigation.navigateTo(LoginRouteSpec());

    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onRegisterPressed(
    RegisterPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Имитация регистрации
    await Future.delayed(const Duration(seconds: 1));

    await _navigation.navigateTo(const RegisterRouteSpec());

    emit(state.copyWith(isLoading: false));
  }

  void _onGoToPersonalPressed(
    GoToPersonalPressed event,
    Emitter<AuthState> emit,
  ) {
    _navigation.navigateTo(
      ProfileMainRouteSpec(userId: 'userid'),
    );
  }
}
