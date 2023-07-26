import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FileController {
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
    try {
      if (_files.length < 7) {
        Fluttertoast.showToast(msg: 'Please Upload all Files');
        return;
      }

      Map<String, String> downloadUrls = {};

      for (int i = 0; i < _files.length; i++) {
        File file = _files[i];
        String fileName = file.path.split('/').last;
        Reference reference = _firebaseStorage
            .ref()
            .child('user-docs')
            .child(user!.uid)
            .child(fileName);
        UploadTask uploadTask = reference.putFile(file);

        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrls[fileName] = downloadUrl;
      }

      await _firestore
          .collection('customers')
          .doc(user!.uid)
          .collection('kyc-docs')
          .doc('user-kyc-docs')
          .set({'fileLinks': downloadUrls});
    } catch (e) {
      // Handle any errors that may occur during file uploading or Firestore operations
      Fluttertoast.showToast(
        msg: "Error.Try Again!",
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
