import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_file_controller.dart';
import 'package:need_moto/owner/controller/owner_image_controller.dart';
import 'package:need_moto/owner/object/kycdocupload.dart';


class TaxFileUpload extends StatefulWidget {
  const TaxFileUpload({super.key});

  @override
  State<TaxFileUpload> createState() => _TaxFileUploadState();
}

class _TaxFileUploadState extends State<TaxFileUpload> {
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
        //   filename: "Vehical RC Front",
        //   filetype: "IMG",
        //   showexp: false,
        // ),
        KycUploadDocumentTile(
            fileName: 'Vehical RC Front', fileController: fileController),
        SizedBox(height: 20),
        KycUploadDocumentTile(
            fileName: 'Vehical RC Back', fileController: fileController),
        // UploadDocument(
        //   filename: "Vehical RC Back",
        //   filetype: "IMG",
        //   showexp: false,
        // ),
        SizedBox(height: 20),
        // UploadDocument(
        //   filename: "Vehicle insurance",
        //   filetype: "PDF",
        //   showexp: true,
        // ),
        KycUploadDocumentTile(
            fileName: 'Vehicle insurance', fileController: fileController),
        SizedBox(height: 20),
        // UploadDocument(
        //   filename: "Your aadar card",
        //   filetype: "IMG",
        //   showexp: false,
        // ),
        KycUploadDocumentTile(
            fileName: 'Your aadar card', fileController: fileController),
        SizedBox(height: 20),
        // UploadDocument(
        //   filename: "Fitness certificate",
        //   filetype: "PDF",
        //   showexp: true,
        // ),
        KycUploadDocumentTile(
            fileName: 'Fitness certificate', fileController: fileController),
        SizedBox(height: 20),
        // UploadDocument(
        //   filename: "Tax document",
        //   filetype: "PDF",
        //   showexp: true,
        // ),
        KycUploadDocumentTile(
            fileName: 'Tax document', fileController: fileController),
        SizedBox(height: 20),
        // UploadDocument(
        //   filename: "Polution",
        //   filetype: "IMG",
        //   showexp: false,
        // ),
        KycUploadDocumentTile(
            fileName: 'Pollution', fileController: fileController),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.red[50],
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(10)),
          child: const Text(
            "* Your documents should be in pdf / jpg / png and size should be more than 2mb",
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
