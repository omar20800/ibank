import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/model/user_model.dart';
import 'package:ibank/core/service/auth_service.dart';
import 'package:ibank/core/service/local_helper.dart';
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
        emit(AuthError(errorMessage: 'No user found after login.'));
        return;
      }
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).update(
        {'lastLogin': DateTime.now()},
      );
      final bool biometricsSuccess =
          await AuthService().authenticateWithBiometrics();
      if (biometricsSuccess) {
        final DocumentSnapshot doc =
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(user.uid)
                .get();
        if (doc.exists && doc.data() != null) {
          final data = doc.data() as Map<String, dynamic>;
          AppLocalStorage.cacheUser(UserModel.fromJson(data));
          emit(AuthSuccess());
        } else {
          log("Error: User data not found in Firestore for UID: ${user.uid}");
          emit(AuthError(errorMessage: 'User data not found.'));
        }
      } else {
        emit(
          AuthError(errorMessage: 'Authentication failed. Please try again.'),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthError(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthError(errorMessage: 'Wrong password provided for that user.'));
      } else {
        emit(
          AuthError(errorMessage: 'An unknown error occurred: ${e.message}'),
        );
      }
    } catch (e) {
      log("Unexpected error during login: $e");
      emit(AuthError(errorMessage: 'An unexpected error occurred.'));
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
        emit(AuthError(errorMessage: 'Failed to create user.'));
        return;
      }
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        'uid': user.uid,
        'name': name,
        'email': emailAddress,
        'balance': 0.0,
        'createdAt': DateTime.now(),
        'lastLogin': DateTime.now(),
        'imageUrl': '',
        'phoneNumber': '',
        'age': 0,
        'criditCards': {},
      });
      AppLocalStorage.cacheUser(
        UserModel(
          age: 0,
          balance: 0.0,
          uid: user.uid,
          name: name,
          email: emailAddress,
          imageUrl: '',
          phoneNumber: '',
        ),
      );
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthError(errorMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(
          AuthError(errorMessage: 'The account already exists for that email.'),
        );
      } else {
        emit(
          AuthError(errorMessage: 'An unknown error occurred: ${e.message}'),
        );
      }
    } catch (e) {
      log("Unexpected error during registration: $e");
      emit(AuthError(errorMessage: 'An unexpected error occurred.'));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signOut();
      await AppLocalStorage.removeUser();
      emit(AuthSuccess());
    } catch (e) {
      log("Error during logout: $e");
      emit(AuthError(errorMessage: 'An unknown error occurred during logout.'));
    }
  }
}
