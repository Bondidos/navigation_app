import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navigation_api/navigation_api.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final INavigation _navigation;

  ProfileBloc(this._navigation) : super(const ProfileState()) {
    on<OpenSettingsPressed>(_onOpenSettingsPressed);
    on<LogoutPressed>(_onLogoutPressed);
    on<GoToAuthPressed>(_onGoToAuthPressed);
  }

  void _onOpenSettingsPressed(
      OpenSettingsPressed event,
      Emitter<ProfileState> emit,
      ) {
    _navigation.navigateTo(
      const ProfileSettingsRouteSpec(),
    );
  }

  Future<void> _onLogoutPressed(
      LogoutPressed event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    await _navigation.navigateTo(
      const LoginRouteSpec(),
    );

    emit(state.copyWith(isLoading: false, isLoggedIn: false));
  }

  void _onGoToAuthPressed(
      GoToAuthPressed event,
      Emitter<ProfileState> emit,
      ) {
    _navigation.navigateTo(
      const LoginRouteSpec(),
    );
  }
}
