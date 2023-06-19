import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:need_moto/admin/controllers/dropdown_controller.dart';

class AdminAddVehicleController extends GetxController
{
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

  Future<void> addVehicleToCollection() async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a new document reference in the "vehicles" collection
      DocumentReference vehicleRef = firestore.collection('vehicles').doc();

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
        // 'ownerID':,
        'ownerName': ownerName.text,
        'pricePerDay': pricePerDay.text,
        'pricePerHourCust': pricePerHour.text,
        'pricePerKm': pricePerKm.text,
        'seating': dropDowncontroller.selectedItem.toString(),
        'type': type.text,
        'vehicleName': "${brand.text} ${model.text}",
        'vehicleNumber': vehicleNumber.text,
      };

      // Add the vehicle data to the Firestore document
      await vehicleRef.set(vehicleData);

      print('Vehicle added successfully!');
    } catch (e) {
      print('Error adding vehicle: $e');
    }
  }

}
