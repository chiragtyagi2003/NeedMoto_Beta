import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String myLabelText;
  bool obscureText = false;
  TextInputField({
    Key? key,
    this.obscureText = false,
    required this.controller,
    required this.myLabelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      // focusNode: FocusScope.of(context).requestFocus(myFocusNode),
      controller: controller,
      decoration: InputDecoration(
        labelText: myLabelText,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(
              color: Colors.grey,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
