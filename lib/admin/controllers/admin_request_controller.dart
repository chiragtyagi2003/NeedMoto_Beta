import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminRequestController extends GetxController {
  final RxList<DocumentSnapshot> requestsData = RxList<DocumentSnapshot>();

  Future<void> fetchBookingData() async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query the "booking" collection
      QuerySnapshot querySnapshot =
          await firestore.collection('requests').get();

      // Store the documents in the bookingData list
      requestsData.assignAll(querySnapshot.docs);
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


  String calculateHoursDifference(String pickupDatetime, String returnDatetime) {
    try {
      // Parse the date strings into DateTime objects
      DateTime pickupDate = DateFormat('dd-MM-yyyy HH:mm').parse(pickupDatetime);
      DateTime returnDate = DateFormat('dd-MM-yyyy HH:mm').parse(returnDatetime);

      // Calculate the difference in hours
      Duration difference = returnDate.difference(pickupDate);
      int differenceInHours = difference.inHours;

      String finalRequestTime = differenceInHours.toString();

      return finalRequestTime;
    } catch (e) {
      // Handle any potential errors that might occur during the date parsing or calculation
      Fluttertoast.showToast(
        msg: "Error.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return 'N/A'; // Return a default value or handle the error as per your requirement
    }
  }


  Future<String?> fetchCustomerName(String userId) async {
    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch the document from the customers collection where docId == userId
      DocumentSnapshot snapshot =
          await firestore.collection('customers').doc(userId).get();

      // Check if the document exists
      if (snapshot.exists) {
        // Retrieve the field value and return it
        return snapshot.get(
            'name'); // Replace 'fieldName' with the actual field name you want to retrieve
      } else {
        // Document does not exist
        Fluttertoast.showToast(
          msg: "Data not found.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[600],
          textColor: Colors.black,
          fontSize: 16.0,
        );
        return null;
      }
    } catch (e) {
      // Error occurred while fetching the document
      Fluttertoast.showToast(
        msg: "Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return null;
    }
  }
}
