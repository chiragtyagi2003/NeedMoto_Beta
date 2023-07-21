import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:need_moto/customer/controllers/Request_Controller.dart';
import 'dart:math';

class VehicleSubmitController extends GetxController {
  TextEditingController vehicleReadingController = TextEditingController();
  TextEditingController vehicleScratchController = TextEditingController();
  TextEditingController vehicleDamageController = TextEditingController();
  TextEditingController vehicleFastTagAmountController =
      TextEditingController();
  TextEditingController vehicleDateTimeOfHandoverController =
      TextEditingController();
  TextEditingController vehicleMessageController = TextEditingController();
  TextEditingController vehicleReceivedDateController = TextEditingController();
  TextEditingController vehicleReceivedTimeController = TextEditingController();
  TextEditingController vehicleTotalDurationController =
      TextEditingController();
  TextEditingController vehicleRideKmController = TextEditingController();
  TextEditingController vehicleSubmitDateController = TextEditingController();
  TextEditingController vehicleSubmitTimeController = TextEditingController();
  TextEditingController vehicleOtherChargesController = TextEditingController();
  TextEditingController vehicleRatingController = TextEditingController();
  TextEditingController vehicleMessageToOwnerController =
      TextEditingController();
  TextEditingController vehicleReceivedDateTimeController =
      TextEditingController();
  TextEditingController vehicleOTPController = TextEditingController();

  RequestController requestController = Get.find();

  void extractSubmitDateAndTime(String dateTimeString) {
    try {
      DateFormat customFormat = DateFormat('dd-MM-yyyy HH:mm');
      DateTime dateTime = customFormat.parse(dateTimeString);

      String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
      String time = DateFormat('HH:mm').format(dateTime);

      vehicleSubmitDateController.text = date;
      vehicleSubmitTimeController.text = time;
    } catch (e) {
      // Handle any errors that may occur during date parsing
      Fluttertoast.showToast(
        msg: 'Error: Invalid date format',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  void extractReceivedDateAndTime(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      String formattedDate =
          '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}';
      String formattedTime =
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

      vehicleReceivedTimeController.text = formattedTime;
      vehicleReceivedDateController.text = formattedDate;
    } catch (e) {
      // Handle any unexpected errors that may occur during date and time formatting
      Fluttertoast.showToast(
        msg: 'Error: Invalid date format',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  String calculateDuration(
      String startDateTimeString, String endDateTimeString) {
    try {
      DateFormat customFormat = DateFormat('dd-MM-yyyy HH:mm');
      DateTime startDateTime = customFormat.parse(startDateTimeString);
      DateTime endDateTime = customFormat.parse(endDateTimeString);

      Duration duration = endDateTime.difference(startDateTime);

      // Calculate the total duration in hours and round off to the greatest integer
      int totalHours = duration.inHours;

      return totalHours.toString();
    } catch (e) {
      // Handle any errors that may occur during date parsing
      Fluttertoast.showToast(
        msg: 'Error: Invalid date format',
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

  int calculateExtraTime(
      String userReturnDateTimeString, String submitDateTimeString) {
    try {
      DateFormat customFormat = DateFormat('dd-MM-yyyy HH:mm');
      DateTime startDateTime = customFormat.parse(userReturnDateTimeString);
      DateTime endDateTime = customFormat.parse(submitDateTimeString);

      Duration extraTime = endDateTime.difference(startDateTime);

      // Calculate the total duration in hours and round off to the greatest integer
      int totalHours = extraTime.inHours;

      return totalHours;
    } catch (e) {
      // Handle any errors that may occur during date parsing
      Fluttertoast.showToast(
        msg: 'Error: Invalid date format',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return 0; // Return a default value or an error code to indicate an error.
    }
  }

  String generateOTP() {
    Random random = Random();
    int otp =
        random.nextInt(9999); // Generate a random number between 0 and 9999
    vehicleOTPController.text = otp.toString().padLeft(4,
        '0'); // Convert the number to a string and pad it with leading zeros if necessary
    return vehicleOTPController.text;
  }

  Future<void> addFieldsToBooking(String documentId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference bookingsCollection = firestore.collection('bookings');

      DocumentReference documentRef = bookingsCollection.doc(documentId);

      await documentRef.update({
        'otp': generateOTP(),
        'received_date': vehicleReceivedDateController.text,
        'received_time': vehicleReceivedTimeController.text,
        'ongoing_ride': true,
        'received_by_owner': false,
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error.',
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
