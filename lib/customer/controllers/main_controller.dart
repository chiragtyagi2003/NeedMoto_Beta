import 'package:cloud_firestore/cloud_firestore.dart';
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
  TextEditingController bookedVehicleNumberController = TextEditingController();

  TextEditingController ownerIDController = TextEditingController();

  TextEditingController vehicleTypeController = TextEditingController();

  TextEditingController assignedVehicleNumberController = TextEditingController();
  TextEditingController assignedOwnerNameController = TextEditingController();
  TextEditingController assignedOwnerPhoneNumberController = TextEditingController();
  TextEditingController assignedVehicleFuelTypeNumberController = TextEditingController();
  TextEditingController assignedOwnerIDController = TextEditingController();


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

  String passOwnerID = "";
  String passVehicleNumber = "";



  String displayValue = "12";

  String calculateDuration(String startDateTimeString, String endDateTimeString) {
    DateFormat customFormat = DateFormat('dd-MM-yyyy HH:mm');
    DateTime startDateTime = customFormat.parse(startDateTimeString);
    DateTime endDateTime = customFormat.parse(endDateTimeString);

    Duration duration = endDateTime.difference(startDateTime);

    // Calculate the total duration in hours and round off to the greatest integer
    int totalHours = duration.inHours;

    return totalHours.toString();
  }

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

  void processOwnerAndVehicle(String ownerId, String vehicleNumber) {
    // Store the ownerId and vehicleNumber in separate variables
    String owner = ownerId;
    String vehicle = vehicleNumber;


    ownerIDController.text = owner;
    bookedVehicleNumberController.text = vehicle;


    // Example: Print the owner and vehicle information
    print('Owner ID: ${ownerIDController.text}');
    print('Vehicle Number: ${bookedVehicleNumberController.text}');
  }

  Future<void> fetchVehicleDetails(String ownerId, String vehicleNumber) async {
    try
    {
      print("Owner ID in fun: ${ownerId}");
      print("vehicleNumber in fun: ${vehicleNumber}");

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

        // Fetch the desired details from the document
// ...

        // Further processing with the fetched details
        // ...
        // Your code here

        // Example: Print the fetched details
      } else {
        print('No matching vehicles found.');
        // Handle the case when no matching vehicles are found
      }
    } catch (error) {
      print('Error fetching vehicle details: $error');
    }
  }




}
