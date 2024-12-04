part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthCheckRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignInGoogleRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInGoogleRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const SignUpRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class UpdatePasswordRequested extends AuthEvent {
  final String newPassword;
  final String currentPassword;

  const UpdatePasswordRequested({
    required this.newPassword,
    required this.currentPassword,
  });

  @override
  List<Object?> get props => [newPassword, currentPassword];
}

class DeleteAccountRequested extends AuthEvent {
  final String currentPassword;

  const DeleteAccountRequested({required this.currentPassword});

  @override
  List<Object?> get props => [currentPassword];
}

class AuthSuccessMessage extends AuthState {
  final String message;

  const AuthSuccessMessage(this.message);

  @override
  List<Object?> get props => [message];
}
