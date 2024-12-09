part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

//class AuthChecking extends AuthState {}
class AuthSuccessState extends AuthState {
  final User user;

  const AuthSuccessState(this.user);

  @override
  List<Object?> get props => [user];
}

class UnauthenticatedState extends AuthState {}

class ConfirmState extends AuthState {}

class AuthErrorState extends AuthState {
  final String? error;

  const AuthErrorState({this.error});
  @override
  List<Object?> get props => [error];
}
