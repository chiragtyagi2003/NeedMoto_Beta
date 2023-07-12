
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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


  void extractSubmitDateAndTime(String dateTimeString) {
    DateFormat customFormat = DateFormat('dd-MM-yyyy HH:mm');
    DateTime dateTime = customFormat.parse(dateTimeString);
    print(dateTime);

    String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    String time = DateFormat('HH:mm').format(dateTime);
    print(time);

    vehicleSubmitDateController.text = date;
    vehicleSubmitTimeController.text = time;
    print(vehicleSubmitTimeController.text);

  }

  void extractReceivedDateAndTime(String dateTimeString) {
    DateFormat customFormat = DateFormat('dd-MM-yyyy HH:mm');
    DateTime dateTime = customFormat.parse(dateTimeString);
    print(dateTime);

    String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    String time = DateFormat('HH:mm').format(dateTime);
    print(time);

    vehicleReceivedDateController.text = date;
    vehicleReceivedTimeController.text = time;
    print(vehicleReceivedTimeController.text);

  }

  String calculateDuration(String receivedDateTimeString, String submitDateTimeString) {
    DateFormat customFormat = DateFormat('dd-MM-yyyy HH:mm');
    DateTime startDateTime = customFormat.parse(receivedDateTimeString);
    DateTime endDateTime = customFormat.parse(submitDateTimeString);

    Duration duration = endDateTime.difference(startDateTime);

    // Calculate the total duration in hours and round off to the greatest integer
    int totalHours = duration.inHours;

    return totalHours.toString();
  }



}