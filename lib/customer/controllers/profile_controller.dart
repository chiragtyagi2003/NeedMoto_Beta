import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();

  Future<void> fetchUserData() async {
    try {
      // Replace 'customers' with your collection name in Firebase
      final snapshot = await FirebaseFirestore.instance
          .collection('customers')
          .doc(currentUserId) // Replace 'user_id_here' with the actual user ID
          .get();

      if (snapshot.exists) {
        final data = snapshot.data();
        userNameController.text = data?['name'];
        userEmailController.text = data?['email'];
        userPhoneController.text = data?['phone'];
      } else {
        Get.snackbar('Error', 'User not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e');
    }
  }
}