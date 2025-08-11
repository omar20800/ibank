import 'package:ibank/core/model/user_model.dart';

class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthError extends AuthStates {
  final String errorMessage;
  AuthError({required this.errorMessage});
}

class AuthSuccess extends AuthStates {}

class GetUserDataSuccess extends AuthStates {
  final UserModel user;
  GetUserDataSuccess({required this.user});
}
class GetUserDataError extends AuthStates {
  final String errorMessage;
  GetUserDataError({required this.errorMessage});
}

class GetUserDataLoading extends AuthStates {}