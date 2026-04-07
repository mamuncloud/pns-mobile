part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthRequestLogin extends AuthEvent {
  final String identifier;

  const AuthRequestLogin(this.identifier);

  @override
  List<Object?> get props => [identifier];
}

class AuthVerifyToken extends AuthEvent {
  final String token;

  const AuthVerifyToken(this.token);

  @override
  List<Object?> get props => [token];
}

class AuthInitialCheckRequested extends AuthEvent {}
