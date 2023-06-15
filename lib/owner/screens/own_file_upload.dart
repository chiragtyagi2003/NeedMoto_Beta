import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/owner_file_controller.dart';
import '../controller/owner_image_controller.dart';
import '../object/kycdocupload.dart';

class OwnFileUpload extends StatefulWidget {
  const OwnFileUpload({super.key});

  @override
  State<OwnFileUpload> createState() => _OwnFileUploadState();
}

class _OwnFileUploadState extends State<OwnFileUpload> {
  final imageController = Get.put(OwnerImageController());
  // final FileController fileController =
  //     Get.put(FileController('qFm8nd1BODSFfJLEsGNFLzjbOiN2'));

  String userID = "";
  late OwnerFileController fileController = Get.put(OwnerFileController());
  //ref for storage for storing kyc docs
  // final storageRef = firebase_storage.FirebaseStorage.instance.ref().child('user-kyc-docs');

  // Get the current user's ID
  String getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user.uid);
      return user.uid;
    }
    return 'qFm8nd1BODSFfJLEsGNFLzjbOiN2';
  }


  // final FileController fileController = Get.put(FileController('qFm8nd1BODSFfJLEsGNFLzjbOiN2'));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userID = getCurrentUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // UploadDocument(
        //   showexp: false,
        //   filename: "Vehical RC Front",
        //   filetype: "IMG",
        // ),
        KycUploadDocumentTile(
            fileName: 'Vehical RC Front', fileController: fileController),
        SizedBox(height: 20),
        KycUploadDocumentTile(
            fileName: 'Vehical RC Back', fileController: fileController),
        // UploadDocument(
        //   showexp: false,
        //   filename: "Vehical RC Back",
        //   filetype: "IMG",
        // ),
        SizedBox(height: 20),
        KycUploadDocumentTile(
            fileName: 'Vehicle insurance', fileController: fileController),
        // UploadDocument(
        //   showexp: false,
        //   filename: "Vehicle insurance",
        //   filetype: "PDF",
        // ),
        SizedBox(height: 20),
        KycUploadDocumentTile(
            fileName: 'Polution', fileController: fileController),
        // UploadDocument(
        //   showexp: false,
        //   filename: "Polution",
        //   filetype: "IMG",
        // ),
        SizedBox(height: 20),
        KycUploadDocumentTile(
            fileName: 'Your aadar card', fileController: fileController),
        // UploadDocument(
        //   showexp: false,
        //   filename: "Your aadar card",
        //   filetype: "IMG",
        // ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.red[50],
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            "* Your documents should be in pdf / jpg / png and size should be more than 2mb",
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
