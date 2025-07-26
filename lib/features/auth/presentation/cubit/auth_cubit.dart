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
      if (value?.data != null) {
        emit(AuthSuccess());
        AppLocalStorage.cacheToken(value!.data!.token!);
        AppLocalStorage.cacheUser(
          UserModel(
            age: value.data?.age,
            balance: value.data?.balance,
            createdAt: value.data?.createdAt,
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
      if (value?.data != null) {
        emit(AuthSuccess());
        AppLocalStorage.cacheToken(value!.data!.token!);
        AppLocalStorage.cacheUser(
          UserModel(
            age: value.data?.age,
            balance: value.data?.balance,
            createdAt: value.data?.createdAt,
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
