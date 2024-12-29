import 'package:chat/models/user_model.dart';

abstract class LoginNavigator {
  void showLoading();
  void hideLoading();
  void showMessage(
      {required String message, bool? posAction, UserModel? userModel});
  void updateUser(UserModel newUser);
}
