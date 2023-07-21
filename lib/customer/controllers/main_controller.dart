import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:need_moto/customer/controllers/DateController.dart';
import 'package:need_moto/customer/screens/StartingPage.dart';
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
  TextEditingController requestStatusController =
      TextEditingController(text: 'pending');
  TextEditingController payPriceController = TextEditingController();
  TextEditingController base12PriceController = TextEditingController();
  TextEditingController base24PriceController = TextEditingController();
  TextEditingController pricePerKmCust = TextEditingController();
  TextEditingController pricePerHourCust = TextEditingController();
  TextEditingController userChoiceHoursController =
      TextEditingController(text: '12');
  TextEditingController distanceController = TextEditingController(text: '150');
  TextEditingController extraHoursController =
      TextEditingController(text: '12');
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController bookedVehicleNumberController = TextEditingController();

  TextEditingController ownerIDController = TextEditingController();

  TextEditingController vehicleTypeController = TextEditingController();

  TextEditingController assignedVehicleNumberController =
      TextEditingController();
  TextEditingController assignedOwnerNameController = TextEditingController();
  TextEditingController assignedOwnerPhoneNumberController =
      TextEditingController();
  TextEditingController assignedVehicleFuelTypeNumberController =
      TextEditingController();
  TextEditingController assignedOwnerIDController = TextEditingController();

  final DateTimeController pickUpdateTimeController = DateTimeController();
  final DateTimeController returnDateTimeController = DateTimeController();
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

  TextEditingController durationDaysHoursController = TextEditingController();

  TextEditingController userChosenTime = TextEditingController();

  String passOwnerID = "";
  String passVehicleNumber = "";

  String displayValue = "12";

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
        msg: 'Error.',
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

  void calculateTimeDifference(String pickupDatetime, String returnDatetime) {
    try {
      // Parse the date strings into DateTime objects
      DateTime pickupDate =
          DateFormat('dd-MM-yyyy HH:mm').parse(pickupDatetime);
      DateTime returnDate =
          DateFormat('dd-MM-yyyy HH:mm').parse(returnDatetime);

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

  void processOwnerAndVehicle(String ownerId, String vehicleNumber) {
    try {
      // Store the ownerId and vehicleNumber in separate variables
      String owner = ownerId;
      String vehicle = vehicleNumber;

      ownerIDController.text = owner;
      bookedVehicleNumberController.text = vehicle;
    } catch (e) {
      // Handle any unexpected errors that may occur during processing
      Fluttertoast.showToast(
        msg: 'Error: Something went wrong.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  Future<void> fetchVehicleDetails(String ownerId, String vehicleNumber) async {
    try {
      // Query the "vehicles" collection for matching documents
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('ownerID', isEqualTo: ownerId)
          .where('vehicleNumber', isEqualTo: vehicleNumber)
          .get();

      // Process the query results
      if (snapshot.docs.isNotEmpty) {
        // Retrieve the first matching document
        DocumentSnapshot document = snapshot.docs.first;
      } else {
        Fluttertoast.showToast(
          msg: "No vehicle found.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[600],
          textColor: Colors.black,
          fontSize: 16.0,
        );
        // Handle the case when no matching vehicles are found
      }
    } catch (error) {
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

  String calculateDurationDaysHours(String startDate, String endDate) {
    try {
      // Parse the start and end dates
      DateTime startDateTime = DateFormat('dd-MM-yyyy HH:mm').parse(startDate);
      DateTime endDateTime = DateFormat('dd-MM-yyyy HH:mm').parse(endDate);

      // Calculate the difference between the two dates
      Duration difference = endDateTime.difference(startDateTime);

      // Calculate the number of days and hours in the duration
      int days = difference.inDays;
      int hours = difference.inHours % 24;

      // Format the duration as "X days, Y hours"
      String formattedDuration = "$days days, $hours hours";

      return formattedDuration;
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

  // Logout User
  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(AnimatedCardsListView());
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
}
