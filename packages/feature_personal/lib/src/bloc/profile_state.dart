part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final bool isLoggedIn;
  final String? userName;

  const ProfileState({
    this.isLoading = false,
    this.isLoggedIn = true,
    this.userName = 'John Doe',
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    String? userName,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      userName: userName ?? this.userName,
    );
  }

  @override
  List<Object?> get props => [isLoading, isLoggedIn, userName];
}