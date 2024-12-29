import 'package:chat/home/home_screen.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class utilsDialog {
  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text(''),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularProgressIndicator(),
            Text('Loading.....'),
          ],
        ),
        // actions: [
        //   TextButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       child: Text('OK')),
        // ],
      ),
    );
  }

  static void showMessage(
      {required BuildContext context,
      required String message,
      bool? posACtion,
      UserModel? userModel,
      String? negActionTitle,
      bool? isRoom,
      Function? negAction})
  // BuildContext context, String message,
  //   [Function? posACtion, String? negActionTitle, Function? negAction])
  {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        title: Text('Title'),
        actions: [
          TextButton(
              onPressed: () {
                if (negAction != null) {
                  negAction;
                }
              },
              child: Text(negActionTitle ?? "")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (isRoom == true) {
                  Navigator.pop(context);
                }
               else if (posACtion == true) {
                  var userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  // userProvider.user = userModel;
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                }
              },
              child: Text('OK')),
        ],
      ),
    );
  }
}
