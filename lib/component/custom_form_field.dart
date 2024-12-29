import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      this.isPassword = false,
     required this.controller,
      required this.title,
      this.isEmail = false});
  final bool isPassword;
  final bool isEmail;
 final TextEditingController controller;
  // final void Function(String)? onChange;
  // final String? Function(String?)? valiadtor;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        obscureText: isPassword,
        // onChanged: onChange,
        controller: controller,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'this field is Required';
          } else if (isPassword) {
            if (value.length < 6) {
              return 'the password is less than 6 charcter';
            }
          } else if (isEmail) {
            bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value);
            if (!emailValid) {
              return 'Please enter Vaild email';
            }
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
