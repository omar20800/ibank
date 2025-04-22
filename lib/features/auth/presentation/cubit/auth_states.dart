class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthError extends AuthStates {
  final String errorMessage;
  AuthError({required this.errorMessage});
}

class AuthSuccess extends AuthStates {}
