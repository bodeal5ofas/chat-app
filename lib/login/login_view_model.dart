import 'package:chat/database/database_utils.dart';
import 'package:chat/login/login_navigator.dart';
import 'package:chat/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  late LoginNavigator navigator;
  void login(String email, String password) async {
    navigator.showLoading();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      UserModel? user = await DatabaseUtils.getUser(credential.user?.uid ?? '');
      if (user == null) {
        navigator.hideLoading();
        navigator.showMessage(message: 'Something went wrong');
      } else {
        navigator.updateUser(user);
        navigator.hideLoading();
        navigator.showMessage(
          message: 'Suceessfully Loin',
          posAction: true,
        );
      }
    } on FirebaseAuthException catch (e) {
      navigator.hideLoading();
      if (e.code == 'user-not-found') {
        navigator.showMessage(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator.showMessage(
            message: 'Wrong password provided for that user.');
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage(message: e.toString());
    }
    notifyListeners();
  }
}
