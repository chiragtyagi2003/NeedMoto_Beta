import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class AdminBookingController extends GetxController {
  RxList<String> carnames = ['Audi', 'Ferrari', 'Mercedes-Benz', 'Hyundai'].obs;
  RxList<String> model = ['A4', 'F40', 'S-class', 'i20'].obs;
  RxList<String> carnumber =
      ['TS28BZ1122', 'TS28BZ2234', 'TS28BZ5124', 'TS28BZ6632'].obs;
  RxList<String> ownernames = ['Ragesh', 'Rajesh', 'Suresh', 'Ramesh'].obs;
  RxList<String> phnos =
      ['+919874563211', '+919632145870', '+919852364177', '+919456871023'].obs;

  RxList<String> customernames = ['Suresh', 'Ramesh', 'Mahesh', 'Ragesh'].obs;
  RxList<int> timeinhrs = [20, 34, 46, 25].obs;
  RxList<int> distanceinkm = [750, 640, 640, 750].obs;
  RxList<String> sources =
      ['Hyderabad', 'Bengaluru', 'Ongole', 'Tirupathi'].obs;
  RxList<String> destination =
      ['Tirupathi', 'Ongole', 'Bengaluru', 'Hyderabad'].obs;

  TextEditingController carName = TextEditingController();
  TextEditingController carNumber = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController requestTime = TextEditingController();
  TextEditingController requestDistance = TextEditingController();
  TextEditingController requestFrom = TextEditingController();
  TextEditingController requestTo = TextEditingController();

  final RxList<DocumentSnapshot> bookingData = RxList<DocumentSnapshot>();
  // Fetch customer names beforehand

  Future<void> fetchBookingData() async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query the "booking" collection
      QuerySnapshot querySnapshot = await firestore.collection('bookings').get();

      // Store the documents in the bookingData list
      bookingData.assignAll(querySnapshot.docs);

      print(bookingData);

      print('Booking data fetched successfully!');
    } catch (e) {
      print('Error fetching booking data: $e');
    }
  }

  String calculateHoursDifference(String pickupDatetime, String returnDatetime) {
    // Parse the date strings into DateTime objects
    DateTime pickupDate = DateFormat('dd-MM-yyyy HH:mm').parse(pickupDatetime);
    DateTime returnDate = DateFormat('dd-MM-yyyy HH:mm').parse(returnDatetime);

    // Calculate the difference in hours
    Duration difference = returnDate.difference(pickupDate);
    int differenceInHours = difference.inHours;

    String finalRequestTime = differenceInHours.toString();

    return finalRequestTime;
  }

  Future<String?> fetchCustomerName(String userId) async {
    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch the document from the customers collection where docId == userId
      DocumentSnapshot snapshot = await firestore.collection('customers').doc(userId).get();

      // Check if the document exists
      if (snapshot.exists) {
        // Retrieve the field value and return it
        return snapshot.get('name'); // Replace 'fieldName' with the actual field name you want to retrieve
      } else {
        // Document does not exist
        return null;
      }
    } catch (e) {
      // Error occurred while fetching the document
      print('Error fetching field value: $e');
      return null;
    }
  }

  Future<String?> fetchOwnerName(String ownerId) async {
    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch the document from the customers collection where docId == userId
      DocumentSnapshot snapshot = await firestore.collection('owners').doc(ownerId).get();

      // Check if the document exists
      if (snapshot.exists) {
        // Retrieve the field value and return it
        return snapshot.get('name'); // Replace 'fieldName' with the actual field name you want to retrieve
      } else {
        // Document does not exist
        return null;
      }
    } catch (e) {
      // Error occurred while fetching the document
      print('Error fetching field value: $e');
      return null;
    }
  }


  Future<String?> fetchOwnerPhoneNumber(String ownerId) async {
    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch the document from the customers collection where docId == userId
      DocumentSnapshot snapshot = await firestore.collection('owners').doc(ownerId).get();

      // Check if the document exists
      if (snapshot.exists) {
        // Retrieve the field value and return it
        return snapshot.get('phone_number'); // Replace 'fieldName' with the actual field name you want to retrieve
      } else {
        // Document does not exist
        return null;
      }
    } catch (e) {
      // Error occurred while fetching the document
      print('Error fetching field value: $e');
      return null;
    }
  }



}