import 'package:dio/dio.dart';
import 'package:ibank/core/service/dio_provider.dart';
import 'package:ibank/features/auth/data/model/request/auth_login_request.dart';
import 'package:ibank/features/auth/data/model/request/auth_request.dart';
import 'package:ibank/features/auth/data/model/response/auth_response/auth_response.dart';
import 'package:ibank/features/auth/data/model/response/get_profile_response/get_profile_response.dart';

class AuthRepo {
  Future<AuthResponse?> isTokenValid(String token) async {
    try {
      var response = await DioProvider.get(
        endpoint: 'auth/is_token_valid',
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  Future<AuthResponse?> login({
    required String emailAddress,
    required String password,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: 'auth/login',
        data: AuthLoginRequest(
          email: emailAddress,
          password: password,
        ).toJson(),
      );
      if (response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  Future<AuthResponse?> register({
    required String name,
    required String emailAddress,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: 'auth/register',
        data: AuthRequest(
          name: name,
          email: emailAddress,
          password: password,
          passwordConfirm: passwordConfirm,
        ).toJson(),
      );
      if (response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  Future<GetProfileResponse?> getUser(String token) async {
    try {
      var response = await DioProvider.get(
        endpoint: 'auth/profile',
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return GetProfileResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  Future<AuthResponse?> logout(String token) async {
    try {
      var response = await DioProvider.post(
        endpoint: 'auth/logout',
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  Future<AuthResponse?> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: 'auth/verify-email',
        data: {"email": email, "otp": otp},
      );
      if (response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  Future<AuthResponse?> requestPasswordReset(String email) async {
    try {
      var response = await DioProvider.post(
        endpoint: 'auth/request-password-reset',
        data: {"email": email},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  Future<AuthResponse?> confirmPasswordReset({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: 'auth/confirm-password-reset',
        data: {
          "email": email,
          "otp": otp,
          "newPassword": newPassword,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  Future<AuthResponse?> passwordOTPVerify ({
    required String email,
    required String otp,
  }) async {
    var response = await DioProvider.post(
      endpoint: 'auth/reset-password-otp-verify',
      data: {
        "email": email,
        "otp": otp,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return AuthResponse.fromJson(response.data);
    }
    return null;
  }
}
