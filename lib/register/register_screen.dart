import 'package:chat/component/custom_form_field.dart';
import 'package:chat/helper.dart';
import 'package:chat/login/login_screen.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/register/register_navigator.dart';
import 'package:chat/register/register_screen_view_model.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = "Home Screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  TextEditingController firstName = TextEditingController(text: 'bola');
  TextEditingController secondName = TextEditingController(text: 'rafat');
  TextEditingController userName = TextEditingController(text: 'bola');
  TextEditingController email = TextEditingController(text: 'bola3@route.com');
  TextEditingController password = TextEditingController(text: '123456');
  GlobalKey<FormState> formKey = GlobalKey();
  RegisterScreenViewModel viewModel = RegisterScreenViewModel();
  @override
  void initState() {
    viewModel.navigator = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
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
              title: Text(
                "Register Account",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        CustomFormField(
                          title: 'First Name',
                          controller: userName,
                        ),
                        CustomFormField(
                          title: "Second Name",
                          controller: secondName,
                        ),
                        CustomFormField(
                            title: 'User Name', controller: userName),
                        CustomFormField(
                          title: 'Email',
                          controller: email,
                          isEmail: true,
                        ),
                        CustomFormField(
                          title: 'Password',
                          controller: password,
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              viewModel.register(
                                  email.text,
                                  password.text,
                                  firstName.text,
                                  secondName.text,
                                  userName.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text(
                            'Register',
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
                                context, LoginScreen.id);
                          },
                          child: Text('Already have Account? Login'),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
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
  void showMessage({required String message, bool? posAction,UserModel? userModel}) {
    utilsDialog.showMessage(
      context: context,
      message: message,
      posACtion: posAction,
      userModel: userModel
    );
  }
  
  @override
  void updateUser(UserModel newUser) {
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    userProvider.changeUser(newUser);
  }
}
