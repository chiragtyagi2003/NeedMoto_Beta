import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/filecontroller.dart';
import '../controllers/imagecontroller.dart';
import '../widget/kyc_appbar.dart';
import '../widget/kycdocupload.dart';
import '../widget/submitbutton.dart';
import '../widget/kycwarning.dart';

class userKYC extends StatefulWidget {
  const userKYC({
    Key? key,
    required this.seats,
    required this.vehicleLocation,
    required this.source,
    required this.destination,
    required this.pickupDateTime,
    required this.returnDateTime,
    required this.delivery,
    required this.purpose,
  }) : super(key: key);
  final RxString seats;
  final String vehicleLocation;
  final String source;
  final String destination;
  final String pickupDateTime;
  final String returnDateTime;
  final String delivery;
  final String purpose;

  @override
  State<userKYC> createState() => _userKYCState();
}

class _userKYCState extends State<userKYC> {
  final imageController = Get.put(ImageController());

  String userID = "";
  late FileController fileController = Get.put(FileController());
  //ref for storage for storing kyc docs
  // final storageRef = firebase_storage.FirebaseStorage.instance.ref().child('user-kyc-docs');

  // Get the current user's ID
  String getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
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
    return Scaffold(
      appBar: const KycAppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Please upload documents to complete KYC',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        final file = File(pickedFile.path);
                        imageController.updateImage(file);
                        fileController.addFile(file);
                      }
                    },
                    child: Obx(
                      () => Container(
                        width: 150,
                        height: 150,
                        //color:Colors.grey,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: imageController.image.value != null
                                ? FileImage(imageController.image.value!)
                                : const NetworkImage(
                                        'https://i.pinimg.com/736x/0b/0e/d9/0b0ed9b43e39d27a7e41beff4fe2e45b.jpg')
                                    as ImageProvider<Object>,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Upload Photo',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              KycUploadDocumentTile(
                  fileName: 'Your Licence Front',
                  fileController: fileController),
              const SizedBox(
                height: 10.0,
              ),
              KycUploadDocumentTile(
                  fileName: 'Your Licence Back',
                  fileController: fileController),
              const SizedBox(
                height: 10.0,
              ),
              KycUploadDocumentTile(
                  fileName: 'Your Aadhaar Front',
                  fileController: fileController),
              const SizedBox(
                height: 10.0,
              ),
              KycUploadDocumentTile(
                  fileName: 'Your Aadhaar Back',
                  fileController: fileController),
              const SizedBox(
                height: 10.0,
              ),
              KycUploadDocumentTile(
                  fileName: 'Cancel Cheque', fileController: fileController),
              const SizedBox(
                height: 10.0,
              ),
              KycUploadDocumentTile(
                  fileName: 'PAN Card', fileController: fileController),
              const SizedBox(height: 30.0),
              const KycWarning(),
              const SizedBox(
                height: 10.0,
              ),
              SubmitButton(
                seats: widget.seats,
                vehicleLocation: widget.vehicleLocation,
                source: widget.source,
                destination: widget.destination,
                pickupDateTime: widget.pickupDateTime,
                returnDateTime: widget.returnDateTime,
                delivery: widget.delivery,
                purpose: widget.purpose,
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
