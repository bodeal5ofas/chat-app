import 'package:chat/home/home_navigator.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  late HomeNavigator navigator;
  late UserProvider userProvider;
  void logout() {
    userProvider.currentUser = null;
  }
}
