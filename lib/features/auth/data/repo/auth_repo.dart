import 'package:dio/dio.dart';
import 'package:ibank/core/service/dio_provider.dart';
import 'package:ibank/features/auth/data/model/request/auth_login_request.dart';
import 'package:ibank/features/auth/data/model/request/auth_request.dart';
import 'package:ibank/features/auth/data/model/response/auth_response/auth_response.dart';

class AuthRepo {
  Future<AuthResponse?> login({
    required String emailAddress,
    required String password,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: 'auth/login',
        data:
            AuthLoginRequest(email: emailAddress, password: password).toJson(),
      );
      if (response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    } catch (e) {
      throw 'Unexpected error';
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
        data:
            AuthRequest(
              name: name,
              email: emailAddress,
              password: password,
              passwordConfirm: passwordConfirm,
            ).toJson(),
      );
      if (response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    } catch (e) {
      throw 'Unexpected error';
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
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    } catch (e) {
      throw 'Unexpected error';
    }
  }
}
