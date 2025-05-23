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
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user?.uid)
          .update({'lastLogin': DateTime.now()});
      AuthService().authenticateWithBiometrics().then((value) {
        if (value == true) {
          final data = FirebaseFirestore.instance
              .collection("Users")
              .doc(user?.uid);
          data.get().then(
            (DocumentSnapshot doc) {
              final data = doc.data() as Map<String, dynamic>;
              AppLocalStorage.cacheUser('user', UserModel.fromJson(data));
            },
            onError: (e) {
              log("Error getting data: $e");
            },
          );
          emit(AuthSuccess());
        } else {
          emit(AuthError(errorMessage: 'Authentication failed'));
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthError(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthError(errorMessage: 'Wrong password provided for that user.'));
      } else {
        emit(AuthError(errorMessage: 'An unknown error occurred.'));
      }
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
      await FirebaseFirestore.instance.collection('Users').doc(user?.uid).set({
        'uid': user?.uid,
        'name': name,
        'email': emailAddress,
        'balance': 0,
        'createdAt': DateTime.now(),
        'lastLogin': DateTime.now(),
        'imageUrl': '',
        'phoneNumber': '',
        'age': 0,
        'criditCards': {},
      });
      AppLocalStorage.cacheUser(
        'user',
        UserModel(
          age: 0,
          balance: 0,
          uid: user?.uid,
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
        emit(AuthError(errorMessage: 'An unknown error occurred.'));
      }
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signOut();
      await AppLocalStorage.removeUser('user');
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(errorMessage: 'An unknown error occurred.'));
    }
  }
}
