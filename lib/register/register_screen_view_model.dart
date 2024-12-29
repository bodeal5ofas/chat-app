import 'package:chat/database/database_utils.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;
  void register(String email, String password, String firstName,
      String lastName, String userName) async {
    try {
      navigator.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel user = UserModel(
          id: credential.user?.uid ?? '',
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          email: email);
      await DatabaseUtils.registerUser(user);
      navigator.updateUser(user);
      navigator.hideLoading();
      navigator.showMessage(
          message: "Successfull Register", posAction: true, userModel: user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideLoading();
        navigator.showMessage(
          message: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        navigator.hideLoading();
        navigator.showMessage(
            message: 'The account already exists for that email.');
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage(message: e.toString());
    }
    notifyListeners();
  }
}
