import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OwnerMainController extends GetxController {
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController vehicleCompanyController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController vehicleCurrentReadingController = TextEditingController();
  TextEditingController vehicleRcNumberController = TextEditingController();
  TextEditingController vehiclePendingChallansController = TextEditingController();
  TextEditingController vehicleInsuranceController = TextEditingController();
  TextEditingController vehicleLocationController = TextEditingController();

  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerPhoneNumberController = TextEditingController();

  Future<void> saveVehicleDataToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    final ownerRef = FirebaseFirestore.instance.collection('owners').doc(user!.uid);
    final vehiclesRef = ownerRef.collection('vehicles');

    final vehicleData = {
      'vehicleName': vehicleNameController.text,
      'vehicleCompany': vehicleCompanyController.text,
      'vehicleNumber': vehicleNumberController.text,
      'vehicleModel': vehicleModelController.text,
      'vehicleCurrentReading': vehicleCurrentReadingController.text,
      'vehicleRcNumber': vehicleRcNumberController.text,
      'vehiclePendingChallans': vehiclePendingChallansController.text,
      'vehicleInsurance': vehicleInsuranceController.text,
      'vehicleLocation': vehicleLocationController.text,
    };

    final vehicleNumber = vehicleNumberController.text;

    try {
      await vehiclesRef.doc(vehicleNumber).set(vehicleData);
      print('Data saved to Firestore successfully!');
    } catch (e) {
      print('Error saving data to Firestore: $e');
    }
  }
}
