import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_main_controller.dart';
import 'package:flutter/material.dart';

class OwnerFileController extends GetxController {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser;

  final List<File> _files = [];

  void addFile(File file) {
    _files.add(file);
  }

  void removeFile(int index) {
    _files.removeAt(index);
  }

  Future<void> uploadFiles() async {
    OwnerMainController mainController = Get.find();
    final vehicleNumber = mainController.vehicleNumberController.text;

    if (_files.length < 7) {
      Get.snackbar("Error", "Please upload all files.");
      return;
    }

    Map<String, String> downloadUrls = {};

    for (int i = 0; i < _files.length; i++) {
      try {
        File file = _files[i];
        String fileName = file.path.split('/').last;
        Reference reference = _firebaseStorage
            .ref()
            .child('owner-docs')
            .child(user!.uid)
            .child('vehicle-docs')
            .child(vehicleNumber)
            .child(fileName);

        UploadTask uploadTask = reference.putFile(file);

        // to listen to progress of uploading
        // uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        //   double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        // });

        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrls[fileName] = downloadUrl;
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
        // Handle the error, show a toast, or take appropriate action.
      }
    }

    try {
      await _firestore
          .collection('owners')
          .doc(user?.uid)
          .collection('docs')
          .doc(vehicleNumber)
          .set({'fileLinks': downloadUrls});
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
      // Handle the error, show a toast, or take appropriate action.
    }
  }
}
