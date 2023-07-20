import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/object/textField.dart';
import '../controller/owner_auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OwnerAuthController ownerAuthController = Get.find();
    // Use media queries to get the available height and width of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: screenHeight * 0.1),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Owner Part",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: screenHeight * 0.06,
                    color: Colors.orange[600]),
              ),
              Text(
                "Enter Details",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: screenHeight * 0.04,
                    color: Colors.orange[600]),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: TextInputField(
                  controller: _emailController,
                  myLabelText: "Email",
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: TextInputField(
                  controller: _nameController,
                  myLabelText: "Name",
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: TextInputField(
                  controller: _phnController,
                  myLabelText: "Phone Number",
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: TextInputField(
                  controller: _passwordController,
                  myLabelText: "Password",
                ),
              ),
              SizedBox(
                height: screenHeight * 0.06,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orange[600]),
                ),
                onPressed: () async {
                  ownerAuthController.signUp(
                    _nameController.text,
                    _emailController.text,
                    _passwordController.text,
                    _phnController.text,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.12,
                    vertical: screenHeight * 0.02,
                  ),
                  child: const Text("Sign Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
