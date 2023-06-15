import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/screens/Home.dart';
import 'package:need_moto/customer/screens/NewLogin.dart';
import 'package:need_moto/owner/screens/signup.dart';
import '../controllers/user_controllers.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  DateTime _selectedDate = DateTime.now();
  UserController userController = Get.find();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> registerUser() async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: userController.userEmailController.text,
        password: userController.userPasswordController.text,
      );

      if (userCredential.user != null) {
        // Access the Firestore instance
        final firestore = FirebaseFirestore.instance;

        // Create a new document in the "customers" collection
        final userDocRef =
        firestore.collection('customers').doc(userCredential.user!.uid);

        // Set the data for the user document
        await userDocRef.set({
          'uid': userCredential.user!.uid,
          'name': userController.userNameController.text,
          'email': userController.userEmailController.text,
          'phone': userController.userPhoneNumberController.text,
          'dob': _selectedDate.toString(),
          'kyc_status': false,
        });

        print('User added to Firestore successfully');
        Get.to(Home());
      }
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  // Future<void> addUserToFirestore() async {
  //   try {
  //     // Access the Firestore instance
  //     final firestore = FirebaseFirestore.instance;
  //
  //     // Create a new document in the "customers" collection
  //     final userDocRef = firestore.collection('customers').doc();
  //
  //     // Set the data for the user document
  //     await userDocRef.set({
  //       'uid': userDocRef.id, // Add the document ID as a field
  //       'name': userController.userNameController.text,
  //       'email': userController.userEmailController.text,
  //       'phone': userController.userPhoneNumberController.text,
  //       'dob': _selectedDate.toString(),
  //       'kyc_status': userController.userKycStatusController.text,
  //     });
  //
  //     print('name: ${userController.userNameController.text}');
  //
  //     print('User added to Firestore successfully');
  //   } catch (e) {
  //     print('Error adding user to Firestore: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Text(
                        //   "Create an Account,Its free",
                        //   style: TextStyle(
                        //     fontSize: 15,
                        //     color: Colors.grey[700],
                        //   ),
                        // ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          makeInput(label: "Name", controller: userController.userNameController),
                          makeInput(label: "Email", controller: userController.userEmailController),
                          makeInput(label: "Password", obsureText: true, controller: userController.userPasswordController),
                          makeInput(
                              label: "Confirm Password", obsureText: true),
                          makeInput(label: "Mobile Number", isNum: true, controller: userController.userPhoneNumberController),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date of Birth",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey))),
                                onTap: () => _selectDate(context),
                                readOnly: true,
                                controller: TextEditingController(
                                    text: _selectedDate == null
                                        ? ''
                                        : '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                                validator: (value) {
                                  if (_selectedDate == null) {
                                    return 'Please select a date';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black))),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            registerUser();
                            Get.to(Home());
                          },
                          color: Color(0xFF182B3A),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        TextButton(
                          onPressed: () {
                            Get.to(() => LoginPage());
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Rent your own vehicle"),
                        TextButton(
                          onPressed: () {
                            Get.to(() => SignUpScreen());
                          },
                          child: Text(
                            "Register as Owner",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget makeInput({label, obsureText = false, isNum = false, TextEditingController? controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      TextField(
        controller: controller,
        keyboardType: isNum ? TextInputType.number : TextInputType.text,
        obscureText: obsureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      SizedBox(
        height: 15,
      )
    ],
  );
}
