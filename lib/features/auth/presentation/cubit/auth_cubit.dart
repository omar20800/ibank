import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/model/user_model.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/features/auth/data/repo/auth_repo.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String emailAddress, String password) async {
    emit(AuthLoading());
    try {
      final value = await AuthRepo().login(
        emailAddress: emailAddress,
        password: password,
      );
      if (value != null) {
        emit(AuthSuccess());
        AppLocalStorage.cacheToken(value.token!);
        AppLocalStorage.cacheUser(UserModel(
          age: value.age,
          balance: value.balance,
          createdAt: value.createdAt,
          email: value.email,
          imageUrl: value.imageUrl,
          lastLogin: value.lastLogin,
          name: value.name,
          phoneNumber: value.phoneNumber,
          uid: value.id,
        ));
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
  ) async {
    emit(AuthLoading());
    try {
      final value = await AuthRepo().register(
        name: name,
        emailAddress: emailAddress,
        password: password,
        passwordConfirm: password,
      );
      if (value != null) {
        emit(AuthSuccess());
        AppLocalStorage.cacheToken(value.token!);
        AppLocalStorage.cacheUser(UserModel(
          age: value.age,
          balance: value.balance,
          createdAt: value.createdAt,
          email: value.email,
          imageUrl: value.imageUrl,
          lastLogin: value.lastLogin,
          name: value.name,
          phoneNumber: value.phoneNumber,
          uid: value.id,
        ));
      } else {
        emit(AuthError(errorMessage: 'Unknown error'));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      if (AppLocalStorage.getToken() == null) return;
      final value = await AuthRepo().logout(AppLocalStorage.getToken()!);
      if (value != null) {
        emit(AuthSuccess());
        AppLocalStorage.removeToken();
      } else {
        emit(AuthError(errorMessage: 'Unknown error'));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }
}
