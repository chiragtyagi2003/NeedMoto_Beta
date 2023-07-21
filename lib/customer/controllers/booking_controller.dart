import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/model/Request_model.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class BookingController extends GetxController {
  final RxList<DocumentSnapshot> myBookings = RxList<DocumentSnapshot>();

  void booking(String from, String to, String pickupDate, String dropDate,
      String delivery, String purpose) async {
    try {
      if (from.isNotEmpty &&
          to.isNotEmpty &&
          pickupDate.isNotEmpty &&
          dropDate.isNotEmpty &&
          delivery.isNotEmpty &&
          purpose.isNotEmpty) {
        data booking = data(
          from: from,
          to: to,
          uid: FirebaseAuth.instance.currentUser!.uid,
          pickupDate: pickupDate,
          dropDate: dropDate,
          delivery: delivery,
          purpose: purpose,
        );

        await FirebaseFirestore.instance
            .collection('bookings')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(booking.toJson());
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

  Future<void> fetchMyBookings(String currentUserId) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userId', isEqualTo: currentUserId)
          .get();

      // Store the documents in the bookingData list
      myBookings.assignAll(querySnapshot.docs);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error. No Data found.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  String calculateHoursDifference(
      String pickupDatetime, String returnDatetime) {
    try {
      // Parse the date strings into DateTime objects
      DateTime pickupDate =
          DateFormat('dd-MM-yyyy HH:mm').parse(pickupDatetime);
      DateTime returnDate =
          DateFormat('dd-MM-yyyy HH:mm').parse(returnDatetime);

      // Calculate the difference in hours
      Duration difference = returnDate.difference(pickupDate);
      int differenceInHours = difference.inHours;

      String finalRequestTime = differenceInHours.toString();
      return finalRequestTime;
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
      return 'Error: Invalid date format';
    }
  }
}
