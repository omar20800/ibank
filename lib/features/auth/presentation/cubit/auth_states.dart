import 'package:ibank/core/model/user_model.dart';

class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthError extends AuthStates {
  final String errorMessage;
  AuthError({required this.errorMessage});
}

class AuthSuccess extends AuthStates {
  final String email;
  AuthSuccess({this.email = ""});
}

class AuthOtpVerified extends AuthStates {}

class AuthOtpVerifiedError extends AuthStates {
  final String email;
  AuthOtpVerifiedError({required this.email});
}

class GetUserDataSuccess extends AuthStates {
  final UserModel user;
  GetUserDataSuccess({required this.user});
}

class GetUserDataError extends AuthStates {
  final String errorMessage;
  GetUserDataError({required this.errorMessage});
}

class GetUserDataLoading extends AuthStates {}

class PasswordResetEmailSent extends AuthStates {
  final String email;
  PasswordResetEmailSent({required this.email});
}

class ChangePasswordSuccessState extends AuthStates {}
