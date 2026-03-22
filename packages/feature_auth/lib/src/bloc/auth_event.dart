part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginPressed extends AuthEvent {
  final String email;
  final String password;

  const LoginPressed({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterPressed extends AuthEvent {
  final String email;
  final String password;
  final String? promoCode;

  const RegisterPressed({
    required this.email,
    required this.password,
    this.promoCode,
  });

  @override
  List<Object?> get props => [email, password, promoCode];
}

class GoToPersonalPressed extends AuthEvent {}