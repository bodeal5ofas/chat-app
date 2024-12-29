//import 'package:chat/database/database_utils.dart';
import 'package:chat/models/user_model.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;

  changeUser(UserModel newUser) {
    currentUser = newUser;
    notifyListeners();
  }
  
  // User? FirebaseUser;
  // UserProvider() {
  //   FirebaseUser = FirebaseAuth.instance.currentUser;
  //   initUser();
  // }
  // initUser()async {
  //   if (FirebaseUser != null) {
  //     user =await DatabaseUtils.getUser(FirebaseUser?.uid?? "");
  //   }
  // }
}
