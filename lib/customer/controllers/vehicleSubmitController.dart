
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


    String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    String time = DateFormat('HH:mm').format(dateTime);

    vehicleSubmitDateController.text = date;
    vehicleSubmitTimeController.text = time;

  }

  void extractReceivedDateAndTime(String dateTimeString) {
    DateFormat customFormat = DateFormat('dd-MM-yyyy HH:mm');
    DateTime dateTime = customFormat.parse(dateTimeString);

    String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    String time = DateFormat('HH:mm').format(dateTime);

    vehicleReceivedDateController.text = date;
    vehicleReceivedTimeController.text = time;

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

}