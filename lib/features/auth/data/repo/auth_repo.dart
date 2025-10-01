import 'package:dio/dio.dart';
import 'package:ibank/core/constants/api_constants.dart';
import 'package:ibank/core/service/dio_provider.dart';
import 'package:ibank/features/auth/data/model/request/auth_login_request.dart';
import 'package:ibank/features/auth/data/model/request/auth_request.dart';
import 'package:ibank/features/auth/data/model/request/confirm_password_reset_request/confirm_password_reset_request.dart';
import 'package:ibank/features/auth/data/model/request/password_reset_request/password_reset_request.dart';
import 'package:ibank/features/auth/data/model/request/store_fcm_token_request/store_fcm_token_request.dart';
import 'package:ibank/features/auth/data/model/request/verify_email_request/verify_email_request.dart';
import 'package:ibank/features/auth/data/model/response/auth_response/auth_response.dart';
import 'package:ibank/features/auth/data/model/response/get_profile_response/get_profile_response.dart';
import 'package:ibank/features/auth/data/model/response/store_fcm_respnse/store_fcm_response.dart';

class AuthRepo {
  bool _isSuccess(int? statusCode) =>
      statusCode != null && (statusCode >= 200 && statusCode < 300);

  Never _handleError(DioException e) {
    throw e.response?.data['message'] ?? 'Something went wrong';
  }

  Future<AuthResponse?> isTokenValid(String token) async {
    try {
      var response = await DioProvider.get(
        endpoint: ApiConstants.authroute + ApiConstants.isTokenValid,
        headers: {
          ApiConstants.authorizationHeader: ApiConstants.bearerToken + token,
        },
      );
      if (_isSuccess(response.statusCode)) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<AuthResponse?> login({
    required String emailAddress,
    required String password,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: ApiConstants.authroute + ApiConstants.login,
        data:
            AuthLoginRequest(email: emailAddress, password: password).toJson(),
      );
      if (_isSuccess(response.statusCode)) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
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
        endpoint: ApiConstants.authroute + ApiConstants.register,
        data:
            AuthRequest(
              name: name,
              email: emailAddress,
              password: password,
              passwordConfirm: passwordConfirm,
            ).toJson(),
      );
      if (_isSuccess(response.statusCode)) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<GetProfileResponse?> getUser(String token) async {
    try {
      var response = await DioProvider.get(
        endpoint: ApiConstants.authroute + ApiConstants.profile,
        headers: {
          ApiConstants.authorizationHeader: ApiConstants.bearerToken + token,
        },
      );
      if (_isSuccess(response.statusCode)) {
        return GetProfileResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<AuthResponse?> uploadProfilePicture({
    required String token,
    required String filePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });
      var response = await DioProvider.uploadFile(
        endpoint: ApiConstants.usersroute + ApiConstants.uploadProfilePic,
        formData: formData,
        headers: {
          ApiConstants.authorizationHeader: ApiConstants.bearerToken + token,
        },
      );

      if (_isSuccess(response.statusCode)) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<AuthResponse?> logout(String token) async {
    try {
      var response = await DioProvider.post(
        endpoint: ApiConstants.authroute + ApiConstants.logout,
        headers: {
          ApiConstants.authorizationHeader: ApiConstants.bearerToken + token,
        },
      );
      if (_isSuccess(response.statusCode)) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<AuthResponse?> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: ApiConstants.authroute + ApiConstants.verifyEmail,
        data: VerifyEmailRequest(email: email, otp: otp).toJson(),
      );
      if (_isSuccess(response.statusCode)) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<AuthResponse?> requestPasswordReset(String email) async {
    try {
      var response = await DioProvider.post(
        endpoint: ApiConstants.authroute + ApiConstants.requestPasswordReset,
        data: PasswordResetRequest(email: email).toJson(),
      );
      if (_isSuccess(response.statusCode)) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<AuthResponse?> confirmPasswordReset({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: ApiConstants.authroute + ApiConstants.confirmPasswordReset,
        data:
            ConfirmPasswordResetRequest(
              email: email,
              otp: otp,
              newPassword: newPassword,
            ).toJson(),
      );
      if (_isSuccess(response.statusCode)) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<AuthResponse?> passwordOTPVerify({
    required String email,
    required String otp,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: ApiConstants.authroute + ApiConstants.resetpasswordotpverify,
        data: VerifyEmailRequest(email: email, otp: otp).toJson(),
      );
      if (_isSuccess(response.statusCode)) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<StoreFcmResponse?> storeFCMToken({
    required String token,
    required String fcmToken,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: ApiConstants.notificationsroute + ApiConstants.storeFcmToken,
        headers: {
          ApiConstants.authorizationHeader: ApiConstants.bearerToken + token,
        },
        data: StoreFcmTokenRequest(fcmToken: fcmToken).toJson(),
      );
      if (_isSuccess(response.statusCode)) {
        return StoreFcmResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      _handleError(e);
    }
  }
}
