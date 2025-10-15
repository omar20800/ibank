import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/model/user_model.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/core/service/notifications_service.dart';
import 'package:ibank/features/auth/data/repo/auth_repo.dart';
import 'package:ibank/features/auth/presentation/auth_constants.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  Future<void> isTokenValid() async {
    emit(AuthLoading());
    try {
      final token = AppLocalStorage.getToken();
      if (token == null) {
        emit(AuthError(errorMessage: AuthConstants.noTokenFoundError));
        return;
      }
      final value = await AuthRepo().isTokenValid(token);
      if (value?.status == true) {
        emit(AuthSuccess());
      } else {
        AppLocalStorage.removeToken();
        emit(AuthError(errorMessage: AuthConstants.invalidTokenError));
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
        if (value?.message == AuthConstants.verifyEmailMessage) {
          emit(AuthOtpVerifiedError(email: emailAddress));
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
          String? fcmToken = await NotificationsService.getFCMToken();
          var result = await AuthRepo().storeFCMToken(
            token: value!.data!.token!,
            fcmToken: fcmToken ?? '',
          );
          if (result?.status == true) {
            emit(AuthSuccess(email: emailAddress));
            AppLocalStorage.cacheToken(value.data!.token!);
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
        }
      } else {
        emit(AuthError(errorMessage: AuthConstants.cannotLoginUnknownError));
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
        emit(AuthError(errorMessage: AuthConstants.cannotRegisterUnknownError));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> passwordOTPVerify(String email, String otp) async {
    emit(AuthLoading());
    try {
      final value = await AuthRepo().passwordOTPVerify(email: email, otp: otp);
      if (value?.status == true) {
        emit(AuthOtpVerified());
      } else {
        emit(
          AuthError(errorMessage: AuthConstants.cannotVerifyOtpUnknownError),
        );
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
        String? fcmToken = await NotificationsService.getFCMToken();
        var result = await AuthRepo().storeFCMToken(
          token: value!.data!.token!,
          fcmToken: fcmToken ?? '',
        );
        if (result?.status == true) {
          emit(AuthOtpVerified());
          AppLocalStorage.cacheToken(value.data!.token!);
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
        emit(
          AuthError(errorMessage: AuthConstants.cannotVerifyOtpUnknownError),
        );
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
        emit(GetUserDataError(errorMessage: AuthConstants.noTokenFoundError));
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
        String? fcmToken = await NotificationsService.getFCMToken();
        var results = await AuthRepo().storeFCMToken(
          token: token,
          fcmToken: fcmToken ?? '',
        );
        if (results?.status == true) {
          emit(GetUserDataSuccess(user: user));
          AppLocalStorage.cacheUser(user);
        }
      } else {
        emit(
          GetUserDataError(errorMessage: AuthConstants.getUserDataUnknownError),
        );
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
        AppLocalStorage.removeToken();
        AppLocalStorage.removeUser();
      } else {
        emit(AuthError(errorMessage: AuthConstants.logoutUnkknownError));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> requestPasswordReset(String email) async {
    emit(AuthLoading());
    try {
      final value = await AuthRepo().requestPasswordReset(email);
      if (value?.status == true) {
        emit(PasswordResetEmailSent(email: email));
      } else {
        emit(
          AuthError(errorMessage: AuthConstants.passwordResetEmailUnknownError),
        );
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> confirmPasswordReset(
    String email,
    String otp,
    String newPassword,
    String newPasswordConfirm,
  ) async {
    emit(AuthLoading());
    try {
      final value = await AuthRepo().confirmPasswordReset(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      if (value?.status == true) {
        emit(ChangePasswordSuccessState());
      } else {
        emit(AuthError(errorMessage: AuthConstants.changePasswordUnknownError));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> uploadProfilePicture(String filePath) async {
    emit(UploadProfilePicLoading());
    try {
      final token = AppLocalStorage.getToken();
      final response = await AuthRepo().uploadProfilePicture(
        token: token ?? '',
        filePath: filePath,
      );
      if (response?.status == true) {
        UserModel user = UserModel(
          age: response?.data?.age,
          balance: response?.data?.balance,
          createdAt: response?.data?.createdAt,
          email: response?.data?.email,
          imageUrl: response?.data?.imageUrl,
          defaultCard: response?.data?.defaultCard,
          lastLogin: response?.data?.lastLogin,
          name: response?.data?.name,
          phoneNumber: response?.data?.phoneNumber,
          uid: response?.data?.id,
        );
        AppLocalStorage.cacheUser(user);
        emit(
          UploadProfilePicSuccess(user: user, message: '${response?.message}'),
        );
      } else {
        emit(
          UploadProfilePicError(
            errorMessage: AuthConstants.uploadProfilePictureUnknownError,
          ),
        );
      }
    } catch (e) {
      emit(UploadProfilePicError(errorMessage: e.toString()));
    }
  }
}
