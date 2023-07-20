import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AdminMainController extends GetxController {
  TextEditingController imgUrlController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController averageController = TextEditingController();
  TextEditingController kpmlController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerPhoneNumberController = TextEditingController();
  TextEditingController rentalPricePerKmController = TextEditingController();
  TextEditingController perKmController = TextEditingController();
  TextEditingController distanceFromYouController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController modelNameController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController distanceRangeController = TextEditingController();
  TextEditingController rentalPricePerDayController = TextEditingController();
  TextEditingController requestStatusController =
      TextEditingController(text: 'pending');
  TextEditingController payPriceController = TextEditingController();
  TextEditingController base12PriceController = TextEditingController();
  TextEditingController base24PriceController = TextEditingController();
  TextEditingController pricePerKmCust = TextEditingController();
  TextEditingController pricePerHourCust = TextEditingController();
  TextEditingController userChoiceHoursController =
      TextEditingController(text: '12');
  TextEditingController distanceController = TextEditingController(text: '150');
  TextEditingController extraHoursController =
      TextEditingController(text: '12');
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController bookedVehicleNumberController = TextEditingController();
  TextEditingController ownerIdController = TextEditingController();

  TextEditingController totalVehiclesController = TextEditingController();
  TextEditingController bookedVehiclesController = TextEditingController();
  TextEditingController availableVehiclesController = TextEditingController();

  // Create an observable list to store the vehicle data
  RxList<DocumentSnapshot<Map<String, dynamic>>> vehicleList =
      RxList<DocumentSnapshot<Map<String, dynamic>>>([]);

  // Function to fetch all documents from the "vehicles" collection
  void fetchVehicleData() async {
    try {
      // Replace 'vehicles' with the name of your Firestore collection
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('vehicles').get();

      vehicleList.assignAll(snapshot.docs);
    } catch (e) {
      // Handle any errors that occur during the fetch process
      Fluttertoast.showToast(
        msg: "Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  Future<void> countAndUpdateVariables() async {
    try {
      // Reference to the 'vehicles' collection
      CollectionReference vehiclesCollection =
          FirebaseFirestore.instance.collection('vehicles');

      // Get the total number of documents in the 'vehicles' collection
      QuerySnapshot allVehiclesSnapshot = await vehiclesCollection.get();
      int total = allVehiclesSnapshot.size;

      // Get the documents where 'onRide' field is true
      QuerySnapshot bookedVehiclesSnapshot =
          await vehiclesCollection.where('onRide', isEqualTo: true).get();
      int booked = bookedVehiclesSnapshot.size;

      // Get the documents where 'onRide' field is false
      QuerySnapshot availableVehiclesSnapshot =
          await vehiclesCollection.where('onRide', isEqualTo: false).get();
      int available = availableVehiclesSnapshot.size;

      // Update the variables
      totalVehiclesController.text = total.toString();
      bookedVehiclesController.text = booked.toString();
      availableVehiclesController.text = available.toString();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error",
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
