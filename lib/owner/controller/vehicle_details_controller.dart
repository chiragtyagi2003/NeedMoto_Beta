import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:need_moto/owner/model/vehicle_details.dart';


class VehicleDetailsController extends GetxController {
  static VehicleDetailsController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void details(
    String vehicleName,
    String vehicleCompany,
    String vehicleNumber,
    String vehicleModel,
    String currentReading,
    String vehicleRcNumber,
    String vehicleLocation,
  ) async {
    try {
      if (vehicleName.isNotEmpty &&
          vehicleCompany.isNotEmpty &&
          vehicleNumber.isNotEmpty &&
          vehicleModel.isNotEmpty &&
          currentReading.isNotEmpty &&
          vehicleRcNumber.isNotEmpty &&

          // fuel_type.isNotEmpty &&
          // own_plate.isNotEmpty &&
          // pending_challans == true &&
          // insurence_vehicle == true &&
          vehicleLocation.isNotEmpty) {
        final User? currentUser = _auth.currentUser;
        VehicleDetails userVehicledetails = VehicleDetails(
          vehicle_name: vehicleName,
          vehicle_company: vehicleCompany,
          vehicle_number: vehicleNumber,
          vehicle_model: vehicleModel,
          current_reading: currentReading,
          vechicle_Rc_number: vehicleRcNumber,
          vehicle_location: vehicleLocation,
        );

        await FirebaseFirestore.instance
            .collection('owners')
            .doc(currentUser!.uid)
            .collection("vehicle_details")
            .doc(vehicleNumber)
            .set(userVehicledetails.toJson());
      } else {
        Get.snackbar("Error Occurred", "Please Enter all fields");
      }
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
    }
  }
}
