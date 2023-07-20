import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_file_controller.dart';
import 'package:need_moto/owner/controller/owner_main_controller.dart';
import 'package:need_moto/owner/object/kycDocUpload.dart';

class OwnerFileUpload extends StatefulWidget {
  const OwnerFileUpload({Key? key}) : super(key: key);

  @override
  State<OwnerFileUpload> createState() => _OwnerFileUploadState();
}

class _OwnerFileUploadState extends State<OwnerFileUpload> {
  late OwnerFileController fileController = Get.find();
  OwnerMainController mainController = Get.find();

  // Get the current user's ID
  String getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return 'qFm8nd1BODSFfJLEsGNFLzjbOiN2';
  }

  String userID = '';

  @override
  void initState() {
    super.initState();
    userID = getCurrentUserId();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate screen size for responsive design
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        // Document upload tile for Vehicle RC Front
        KycUploadDocumentTile(
          fileName: 'Vehicle RC Front',
          fileController: fileController,
        ),
        SizedBox(height: size.height * 0.02), // Vertical spacing

        // Document upload tile for Vehicle RC Back
        KycUploadDocumentTile(
          fileName: 'Vehicle RC Back',
          fileController: fileController,
        ),
        SizedBox(height: size.height * 0.02), // Vertical spacing

        // Document upload tile for Vehicle insurance
        KycUploadDocumentTile(
          fileName: 'Vehicle insurance',
          fileController: fileController,
        ),
        SizedBox(height: size.height * 0.02), // Vertical spacing

        // Document upload tile for Your Aadhaar card
        KycUploadDocumentTile(
          fileName: 'Your Aadhaar card',
          fileController: fileController,
        ),
        SizedBox(height: size.height * 0.02), // Vertical spacing

        // Document upload tile for Fitness certificate
        KycUploadDocumentTile(
          fileName: 'Fitness certificate',
          fileController: fileController,
        ),
        SizedBox(height: size.height * 0.02), // Vertical spacing

        // Document upload tile for Tax document
        KycUploadDocumentTile(
          fileName: 'Tax document',
          fileController: fileController,
        ),
        SizedBox(height: size.height * 0.02), // Vertical spacing

        // Document upload tile for Pollution
        KycUploadDocumentTile(
          fileName: 'Pollution',
          fileController: fileController,
        ),

        Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.04, vertical: size.height * 0.02),
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04, vertical: size.height * 0.015),
          decoration: BoxDecoration(
            color: Colors.red[50],
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "* Your documents should be in pdf / jpg / png and size should be from 300KB to 2MB",
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
