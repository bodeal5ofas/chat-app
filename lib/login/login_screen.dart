import 'package:chat/component/custom_form_field.dart';
import 'package:chat/helper.dart';
import 'package:chat/login/login_navigator.dart';
import 'package:chat/login/login_view_model.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'Login screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController =
      TextEditingController(text: 'bola@route.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  LoginViewModel viewModel = LoginViewModel();
  @override
  void initState() {
    viewModel.navigator = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          'assets/background.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            title: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      CustomFormField(
                        title: 'Email',
                        controller: emailController,
                        isEmail: true,
                      ),
                      CustomFormField(
                        title: 'Password',
                        controller: passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            viewModel.login(
                                emailController.text, passwordController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RegisterScreen.id);
                        },
                        child: Text('Donot have Account? Register'),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }

  @override
  void hideLoading() {
    utilsDialog.hideLoading(context);
  }

  @override
  void showLoading() {
    utilsDialog.showLoading(context);
  }

  @override
  void showMessage(
      {required String message, bool? posAction, UserModel? userModel}) {
    utilsDialog.showMessage(
        context: context,
        message: message,
        posACtion: posAction,
        userModel: userModel);
  }

  @override
  void updateUser(UserModel newUser) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.changeUser(newUser);
  }
}
