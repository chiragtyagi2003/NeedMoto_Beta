
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:need_moto/customer/controllers/Request_Controller.dart';
import 'dart:math';


class VehicleSubmitController extends GetxController{

  TextEditingController vehicleReadingController = TextEditingController();
  TextEditingController vehicleScratchController = TextEditingController();
  TextEditingController vehicleDamageController = TextEditingController();
  TextEditingController vehicleFastTagAmountController = TextEditingController();
  TextEditingController vehicleDateTimeOfHandoverController = TextEditingController();
  TextEditingController vehicleMessageController = TextEditingController();
  TextEditingController vehicleReceivedDateController = TextEditingController();
  TextEditingController vehicleReceivedTimeController = TextEditingController();
  TextEditingController vehicleTotalDurationController = TextEditingController();
  TextEditingController vehicleRideKmController = TextEditingController();
  TextEditingController vehicleSubmitDateController = TextEditingController();
  TextEditingController vehicleSubmitTimeController = TextEditingController();
  TextEditingController vehicleOtherChargesController = TextEditingController();
  TextEditingController vehicleRatingController = TextEditingController();
  TextEditingController vehicleMessageToOwnerController = TextEditingController();
  TextEditingController vehicleReceivedDateTimeController = TextEditingController();
  TextEditingController vehicleOTPController = TextEditingController();


  RequestController requestController = Get.find();



  void extractSubmitDateAndTime(String dateTimeString) {
    DateFormat customFormat = DateFormat('dd-MM-yyyy HH:mm');
    DateTime dateTime = customFormat.parse(dateTimeString);


    String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    String time = DateFormat('HH:mm').format(dateTime);

    vehicleSubmitDateController.text = date;
    vehicleSubmitTimeController.text = time;

  }



    void extractReceivedDateAndTime(String dateTimeString) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      String formattedDate =
          '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}';
      String formattedTime =
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

      print("Date: $formattedDate");
      print("Time: $formattedTime");
      vehicleReceivedTimeController.text = formattedTime;
      vehicleReceivedDateController.text = formattedDate;
    }


    String calculateDuration(String startDateTimeString, String endDateTimeString) {
    DateFormat customFormat = DateFormat('dd-MM-yyyy HH:mm');
    DateTime startDateTime = customFormat.parse(startDateTimeString);
    DateTime endDateTime = customFormat.parse(endDateTimeString);

    Duration duration = endDateTime.difference(startDateTime);

    // Calculate the total duration in hours and round off to the greatest integer
    int totalHours = duration.inHours;

    return totalHours.toString();
  }

  int calculateExtraTime(String userReturnDateTimeString, String submitDateTimeString) {
    DateFormat customFormat = DateFormat('dd-MM-yyyy HH:mm');
    DateTime startDateTime = customFormat.parse(userReturnDateTimeString);
    DateTime endDateTime = customFormat.parse(submitDateTimeString);

    Duration extraTime = endDateTime.difference(startDateTime);

    // Calculate the total duration in hours and round off to the greatest integer
    int totalHours = extraTime.inHours;

    return totalHours;
  }

  String generateOTP() {
    Random random = Random();
    int otp = random.nextInt(9999); // Generate a random number between 0 and 9999
    vehicleOTPController.text =  otp.toString().padLeft(4, '0'); // Convert the number to a string and pad it with leading zeros if necessary
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

      print('New fields added successfully!');
    } catch (e) {
      print('Error adding new fields: $e');
    }
  }

}