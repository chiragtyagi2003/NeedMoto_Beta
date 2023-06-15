import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_main_controller.dart';



class OwnerFileController extends GetxController
{
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final String _userId;
  // FileController(this._userId);

  final user = FirebaseAuth.instance.currentUser;


  List<File> _files = [];

  void addFile(File file) {
    _files.add(file);
    print('Files: ${_files}');
  }

  void removeFile(int index) {
    _files.removeAt(index);
  }

  Future<void> uploadFiles() async {
    OwnerMainController mainController = Get.find();
    final vehicleNumber = mainController.vehicleNumberController.text;


    if (_files.length < 7) {
      print('Please upload all files.');
      //Fluttertoast.showToast(msg: 'Please Upload all Files');

      return;
    }
    Map<String, String> downloadUrls =
        {}; // Use a map instead of a list to store key-value pairs
    for (int i = 0; i < _files.length; i++) {
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

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        print('Upload progress: $progress');
      });

      TaskSnapshot taskSnapshot = await uploadTask;
      print('File uploaded');
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      downloadUrls[fileName] = downloadUrl; // Use the filename as the key
    }

    // await _firestore
    //     .collection('customers')
    //     .doc(_userId)
    //     .collection('kyc-docs')
    //     .doc('user-kyc-docs')
    //     .set({'fileLinks': downloadUrls});
  }
}
