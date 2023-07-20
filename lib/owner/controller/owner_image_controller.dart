import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:need_moto/owner/controller/owner_main_controller.dart';
import 'package:flutter/material.dart';

class OwnerImageController extends GetxController {
  OwnerMainController mainController = Get.find();
  // var images = RxnList<File>();
  RxList<File> images = <File>[].obs;

  void updateImages(List<File> files) {
    images.value = files;
  }

  Future<void> uploadImagesToFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    final userUid = user?.uid;

    final vehicleNumber = mainController.vehicleNumberController.text;

    List<String> imageUrls = []; // List to store the image URLs

    if (images.length < 6) {
      Fluttertoast.showToast(
        msg: "Error. Please upload at least 6 images.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }

    for (var i = 0; i < images.length; i++) {
      final imageFile = images[i];
      final fileName =
          'image_$i.jpg'; // Generate a unique file name for each image

      final firebaseStorageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('owner-docs/$userUid/vehicle-photos/$vehicleNumber/$fileName');

      try {
        await firebaseStorageRef.putFile(imageFile);
        String downloadUrl = await firebaseStorageRef.getDownloadURL();
        imageUrls.add(downloadUrl); // Add the URL to the list

        // Upload the image URLs to Firestore in the "vehicle-number" document
        await FirebaseFirestore.instance
            .collection('owners')
            .doc(userUid)
            .collection('vehicle-number')
            .doc(vehicleNumber)
            .update({'imageUrls': imageUrls});
      } catch (e) {
        // Handle any errors that occur during the upload process
        Fluttertoast.showToast(
          msg: "Error. Image not uploaded, try again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[600],
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
    }
  }
}
