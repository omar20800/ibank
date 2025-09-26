import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/model/user_model.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/features/auth/data/repo/auth_repo.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  Future<void> isTokenValid() async {
    emit(AuthLoading());
    try {
      final token = AppLocalStorage.getToken();
      if (token == null) {
        emit(AuthError(errorMessage: 'No token found'));
        return;
      }
      final value = await AuthRepo().isTokenValid(token);
      if (value?.status == true) {
        emit(AuthSuccess());
        log("Token is valid Login successful");
      } else {
        AppLocalStorage.removeToken();
        emit(AuthError(errorMessage: 'Token is invalid'));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> login(String emailAddress, String password) async {
    emit(AuthLoading());
    try {
      final value = await AuthRepo().login(
        emailAddress: emailAddress,
        password: password,
      );
      if (value?.status == true) {
        if (value?.message == "Please verify your email before logging in") {
          emit(AuthOtpVerifiedError(email: emailAddress));
          log("Please verify your email before logging in");
          AppLocalStorage.cacheToken(value!.data!.token!);
          AppLocalStorage.cacheUser(
            UserModel(
              age: value.data?.age,
              balance: value.data?.balance,
              createdAt: value.data?.createdAt,
              defaultCard: value.data?.defaultCard,
              email: value.data?.email,
              imageUrl: value.data?.imageUrl,
              lastLogin: value.data?.lastLogin,
              name: value.data?.name,
              phoneNumber: value.data?.phoneNumber,
              uid: value.data?.id,
            ),
          );
        } else {
          emit(AuthSuccess());
          log("User data: ${value?.data?.toJson()}");
          AppLocalStorage.cacheToken(value!.data!.token!);
          AppLocalStorage.cacheUser(
            UserModel(
              age: value.data?.age,
              balance: value.data?.balance,
              createdAt: value.data?.createdAt,
              defaultCard: value.data?.defaultCard,
              email: value.data?.email,
              imageUrl: value.data?.imageUrl,
              lastLogin: value.data?.lastLogin,
              name: value.data?.name,
              phoneNumber: value.data?.phoneNumber,
              uid: value.data?.id,
            ),
          );
        }
      } else {
        emit(AuthError(errorMessage: 'Unknown error'));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> register(
    String name,
    String emailAddress,
    String password,
    String passwordConfirm,
  ) async {
    emit(AuthLoading());
    try {
      final value = await AuthRepo().register(
        name: name,
        emailAddress: emailAddress,
        password: password,
        passwordConfirm: passwordConfirm,
      );
      if (value?.data != null) {
        emit(AuthSuccess(email: emailAddress));
        log("User data: ${value?.data?.toJson()}");
        AppLocalStorage.cacheToken(value!.data!.token!);
        AppLocalStorage.cacheUser(
          UserModel(
            age: value.data?.age,
            balance: value.data?.balance,
            createdAt: value.data?.createdAt,
            defaultCard: value.data?.defaultCard,
            email: value.data?.email,
            imageUrl: value.data?.imageUrl,
            lastLogin: value.data?.lastLogin,
            name: value.data?.name,
            phoneNumber: value.data?.phoneNumber,
            uid: value.data?.id,
          ),
        );
      } else {
        emit(AuthError(errorMessage: 'Unknown error'));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> verifyEmail(String email, String otp) async {
    emit(AuthLoading());
    try {
      final value = await AuthRepo().verifyEmail(email: email, otp: otp);
      if (value?.status == true) {
        emit(AuthOtpVerified());
        log("Email verified successfully");
        AppLocalStorage.cacheToken(value!.data!.token!);
        AppLocalStorage.cacheUser(
          UserModel(
            age: value.data?.age,
            balance: value.data?.balance,
            createdAt: value.data?.createdAt,
            defaultCard: value.data?.defaultCard,
            email: value.data?.email,
            imageUrl: value.data?.imageUrl,
            lastLogin: value.data?.lastLogin,
            name: value.data?.name,
            phoneNumber: value.data?.phoneNumber,
            uid: value.data?.id,
          ),
        );
      } else {
        emit(AuthError(errorMessage: 'Unknown error'));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> getUser() async {
    emit(GetUserDataLoading());
    try {
      final token = AppLocalStorage.getToken();
      if (token == null) {
        emit(GetUserDataError(errorMessage: 'No token found'));
        return;
      }
      final value = await AuthRepo().getUser(token);
      if (value?.status == true) {
        UserModel? user = UserModel(
          age: value?.data?.age,
          balance: value?.data?.balance,
          createdAt: value?.data?.createdAt,
          email: value?.data?.email,
          imageUrl: value?.data?.imageUrl,
          defaultCard: value?.data?.defaultCard,
          lastLogin: value?.data?.lastLogin,
          name: value?.data?.name,
          phoneNumber: value?.data?.phoneNumber,
          uid: value?.data?.id,
        );
        emit(GetUserDataSuccess(user: user));
        log("User data: ${value?.data?.toJson()}");
        AppLocalStorage.cacheUser(user);
      } else {
        emit(GetUserDataError(errorMessage: 'Unknown error'));
      }
    } catch (e) {
      emit(GetUserDataError(errorMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      if (AppLocalStorage.getToken() == null) return;
      final value = await AuthRepo().logout(AppLocalStorage.getToken()!);
      if (value?.status == true) {
        emit(AuthSuccess());
        log("Logout successful");
        AppLocalStorage.removeToken();
      } else {
        emit(AuthError(errorMessage: 'Unknown error'));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }
}
