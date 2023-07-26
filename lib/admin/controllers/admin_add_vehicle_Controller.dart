import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:need_moto/admin/controllers/dropdown_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminAddVehicleController extends GetxController {
  TextEditingController average = TextEditingController();
  TextEditingController base12 = TextEditingController();
  TextEditingController base24 = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController distanceRange = TextEditingController();
  TextEditingController kmpl = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController ownerName = TextEditingController();
  TextEditingController pricePerDay = TextEditingController();
  TextEditingController pricePerHour = TextEditingController();
  TextEditingController pricePerKm = TextEditingController();
  TextEditingController numOfSeats = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController vehicleNumber = TextEditingController();
  DropdownController dropDowncontroller = DropdownController();
  TextEditingController vehicleTypeController = TextEditingController();
  Future<void> addVehicleToCollection(String vehicleId) async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a new document reference in the "vehicles" collection
      DocumentReference vehicleRef =
          firestore.collection('vehicles').doc(vehicleId);

      // Create a map containing the vehicle data
      Map<String, dynamic> vehicleData = {
        'average': average.text,
        'base_12': base12.text,
        'base_24': base24.text,
        'brandName': brand.text,
        'description': description.text,
        'distanceRange': distanceRange.text,
        'kmpl': kmpl.text,
        'model': model.text,
        'pricePerDay': pricePerDay.text,
        'pricePerHourCust': pricePerHour.text,
        'pricePerKmCust': pricePerKm.text,
        'seating': dropDowncontroller.selectedItem.toString(),
        'adminApproval': true,
        'vehicleType': vehicleTypeController.text,
      };

      // Add the vehicle data to the Firestore document
      await vehicleRef.update(vehicleData);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error Adding Vehicle.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchVehicleDetails(
      String vehicleId) async {
    try {
      // Assuming you have a collection 'vehicles' in Firestore
      var vehicleDocument = await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(vehicleId)
          .get();

      ownerName.text = vehicleDocument['ownerName'];
      vehicleNumber.text = vehicleDocument['vehicleNumber'];

      return vehicleDocument;
    } catch (e) {
      // Handle any potential errors that might occur during the data retrieval process
      Fluttertoast.showToast(
        msg: "Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
      throw Exception('Failed to fetch vehicle details: $e');
    }
  }
}
