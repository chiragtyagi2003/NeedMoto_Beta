import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:need_moto/customer/controllers/DateController.dart';
import '../controllers/Dropdown.dart';
import 'package:intl/intl.dart';

class MainController extends GetxController {
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
  TextEditingController requestStatusController = TextEditingController(text: 'pending');
  TextEditingController payPriceController = TextEditingController();
  TextEditingController base12PriceController = TextEditingController();
  TextEditingController base24PriceController = TextEditingController();
  TextEditingController pricePerKmCust = TextEditingController();
  TextEditingController pricePerHourCust = TextEditingController();
  TextEditingController userChoiceHoursController = TextEditingController(text: '12');
  TextEditingController distanceController = TextEditingController(text: '150');
  TextEditingController extraHoursController = TextEditingController(text: '12');
  TextEditingController totalPriceController = TextEditingController();

  TextEditingController vehicleTypeController = TextEditingController();


  final DateTimeController pickUpdateTimeController = DateTimeController();
  final DateTimeController returndateTimeController = DateTimeController();
  TextEditingController vehicleNeedLocations = TextEditingController();
  TextEditingController vehicleSource = TextEditingController();
  TextEditingController vehicleDestination = TextEditingController();
  TextEditingController pickupDateTime = TextEditingController();
  TextEditingController returnDateTime = TextEditingController();
  TextEditingController delivery = TextEditingController();
  TextEditingController purpose = TextEditingController();
  TextEditingController filterSeats = TextEditingController();
  DropdownController deliveryDropDownController = DropdownController();
  DropdownController seatsDropDownController = DropdownController();


  TextEditingController userChosenTime = TextEditingController();

  String displayValue = "12";

  void calculateTimeDifference(String pickupDatetime, String returnDatetime) {
    // Parse the date strings into DateTime objects
    DateTime pickupDate = DateFormat('dd-MM-yyyy HH:mm').parse(pickupDatetime);
    DateTime returnDate = DateFormat('dd-MM-yyyy HH:mm').parse(returnDatetime);

    // Calculate the difference in days and hours
    Duration difference = returnDate.difference(pickupDate);
    int differenceInDays = difference.inDays;
    int differenceInHours = difference.inHours % 24;

    // Build the final time string
    String finalTime = '';
    if (differenceInDays > 0) {
      finalTime = '$differenceInDays days ';
    }
    finalTime += '$differenceInHours hours';

    userChosenTime.text = finalTime;
  }




}
