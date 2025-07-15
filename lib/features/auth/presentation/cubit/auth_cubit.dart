import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/model/user_model.dart';
import 'package:ibank/core/service/auth_service.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/features/auth/presentation/auth_constants.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String emailAddress, String password) async {
    emit(AuthLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      User? user = credential.user;
      if (user == null) {
        emit(AuthError(errorMessage: AuthConstants.loginunexpectederror));
        return;
      }
      await FirebaseFirestore.instance.collection(AuthConstants.userscollection).doc(user.uid).update(
        {AuthConstants.lastlogin : DateTime.now()},
      );
      final bool biometricsSuccess =
          await AuthService().authenticateWithBiometrics();
      if (biometricsSuccess) {
        final DocumentSnapshot doc =
            await FirebaseFirestore.instance
                .collection(AuthConstants.userscollection)
                .doc(user.uid)
                .get();
        if (doc.exists && doc.data() != null) {
          final data = doc.data() as Map<String, dynamic>;
          await AppLocalStorage.cacheUser(UserModel.fromJson(data));
          emit(AuthSuccess());
        } else {
          emit(AuthError(errorMessage: AuthConstants.userdatanotfound));
        }
      } else {
        emit(
          AuthError(errorMessage: AuthConstants.loginunexpectederror),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthConstants.userdatanotfounderrorcode) {
        emit(AuthError(errorMessage: AuthConstants.userdatanotfound));
      } else if (e.code == AuthConstants.wrongpassworderrorcode) {
        emit(AuthError(errorMessage: AuthConstants.wrongpassworderrormessage));
      } else {
        emit(
          AuthError(errorMessage: AuthConstants.loginunexpectederror + e.message.toString()),
        );
      }
    } catch (e) {
      emit(AuthError(errorMessage: AuthConstants.loginunexpectederror + e.toString()));
    }
  }

  Future<void> register(
    String name,
    String emailAddress,
    String password,
  ) async {
    emit(AuthLoading());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      User? user = credential.user;
      if (user == null) {
        emit(AuthError(errorMessage: AuthConstants.registerunexpectederror));
        return;
      }
      UserModel userdata = UserModel(
          age: 0,
          balance: 0.0,
          uid: user.uid,
          name: name,
          email: emailAddress,
          imageUrl: '',
          phoneNumber: '',
          lastLogin: DateTime.now(),
          createdAt: DateTime.now()
      );
      await FirebaseFirestore.instance.collection(AuthConstants.userscollection).doc(user.uid).set(userdata.toJson());
      await AppLocalStorage.cacheUser(userdata);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthConstants.weakpassworderrorcode) {
        emit(AuthError(errorMessage: AuthConstants.weakpassworderrormessage));
      } else if (e.code == AuthConstants.emailalreadyexistserrorcode) {
        emit(
          AuthError(errorMessage: AuthConstants.emailalreadyexistserrormessage),
        );
      } else {
        emit(
          AuthError(errorMessage: AuthConstants.registerunexpectederror + e.message.toString()),
        );
      }
    } catch (e) {
      log(AuthConstants.registerunexpectederror + e.toString());
      emit(AuthError(errorMessage: AuthConstants.registerunexpectederror + e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signOut();
      await AppLocalStorage.removeUser();
      emit(AuthSuccess());
    } catch (e) {
      log(AuthConstants.logoutunexpectederror + e.toString());
      emit(AuthError(errorMessage: AuthConstants.logoutunexpectederror + e.toString()));
    }
  }
}
