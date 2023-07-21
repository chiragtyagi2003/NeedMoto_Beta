import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class VehicleBookingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _carsRef;
  late List<Map<String, dynamic>> _allCars = [];
  final RxList<Map<String, dynamic>> filteredCars =
      RxList<Map<String, dynamic>>([]);

  @override
  void onInit() {
    super.onInit();
    _carsRef = _firestore.collection('vehicles');
    _loadAllCars();
  }

  Future<void> _loadAllCars() async {
    try {
      final QuerySnapshot querySnapshot = await _carsRef.get();
      _allCars = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      filteredCars.addAll(_allCars);
    } catch (e) {
      // Handle any unexpected errors that may occur during Firestore queries
      Fluttertoast.showToast(
        msg: 'Error.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
      // You can show an error message to the user or handle the error in another way.
    }
  }

  void filterCars(String seatsString) {
    try {
      int seats = int.parse(seatsString);
      if (seats == 0) {
        filteredCars.assignAll(_allCars);
      } else if (seats == 6) {
        final List<Map<String, dynamic>> filtered = _allCars
            .where((car) => int.parse(car['seating']) >= seats)
            .toList();
        filteredCars.assignAll(filtered);
      } else {
        final List<Map<String, dynamic>> filtered = _allCars
            .where((car) => int.parse(car['seating']) == seats)
            .toList();
        filteredCars.assignAll(filtered);
      }
    } catch (e) {
      // Handle any unexpected errors that may occur during filtering
      Fluttertoast.showToast(
        msg: 'Error.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
      // You can show an error message to the user or handle the error in another way.
    }
  }
}
