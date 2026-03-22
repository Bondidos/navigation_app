part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class OpenSettingsPressed extends ProfileEvent {}

class LogoutPressed extends ProfileEvent {}

class GoToAuthPressed extends ProfileEvent {}