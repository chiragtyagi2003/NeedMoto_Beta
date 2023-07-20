import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AdminPaymentsController extends GetxController {

  final RxList<DocumentSnapshot> paymentData = RxList<DocumentSnapshot>();
  // Fetch customer names beforehand

  Future<void> fetchBookingData() async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query the "booking" collection
      QuerySnapshot querySnapshot = await firestore.collection('bookings').get();

      // Store the documents in the bookingData list
      paymentData.assignAll(querySnapshot.docs);

    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
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