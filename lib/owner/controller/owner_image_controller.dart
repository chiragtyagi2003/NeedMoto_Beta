import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:need_moto/owner/controller/owner_main_controller.dart';


class OwnerImageController extends GetxController {

  OwnerMainController mainController = Get.find();
  // var images = RxnList<File>();
  RxList<File> images = <File>[].obs;

  void updateImages(List<File> files) {
    images.value = files;
  }

  Future<void> uploadImagesToFirebase() async {
    final user = FirebaseAuth.instance.currentUser; //Replace with the actual user ID
    final userUid = user?.uid;



    print('USER ID: $userUid');

    for (var i = 0; i < images.length; i++) {
      final imageFile = images[i];
      final fileName = 'image_$i.jpg'; // Generate a unique file name for each image

      // final firebaseStorageRef = firebase_storage.FirebaseStorage.instance
      //     .ref()
      //     .child('owner-docs/$userUid/vehicle-photos/$fileName');

      final vehicleNumber = mainController.vehicleNumberController.text;
      final firebaseStorageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('owner-docs/$userUid/vehicle-photos/$vehicleNumber/$fileName');

      try {
        await firebaseStorageRef.putFile(imageFile);
        // You can do further processing or error handling here if needed
      } catch (e) {
        // Handle any errors that occur during the upload process
        print('Error uploading image: $e');
      }
    }
  }
}