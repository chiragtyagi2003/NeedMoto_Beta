import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:need_moto/customer/screens/StartingPage.dart';
import 'package:need_moto/owner/screens/ownerHome.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class OwnerAuthController extends GetxController {
  void signUp(
    String name,
    String email,
    String password,
    String phoneNumber,
  ) async {
    try {
      if (name.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          phoneNumber.isNotEmpty) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        myUser user = myUser(
            name: name,
            email: email,
            uid: credential.user!.uid,
            phone_number: phoneNumber);

        await FirebaseFirestore.instance
            .collection('owners')
            .doc(credential.user!.uid)
            .set(user.toJson());

        // Store the device token in Firestore
        String? deviceToken = await FirebaseMessaging.instance.getToken();
        await FirebaseFirestore.instance
            .collection('owners')
            .doc(credential.user!.uid)
            .update({'device_token': deviceToken});
        Get.offAll(() => const OwnerHome());
      } else {
        Get.snackbar("Error Occurred", "Please Enter all fields!");
      }
    } catch (e) {
      Get.snackbar("Error Occurred", e.toString());
    }
  }

  // Login User
  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        Get.offAll(() => const OwnerHome());
      } else {
        Get.snackbar("Error", "Please enter your email and password");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Logout User
  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(AnimatedCardsListView());
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }
}
