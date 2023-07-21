import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';

class RequestController extends GetxController {
  RxList productData = [].obs;
  var status = ''.obs;

  MainController mainController = Get.find();

  final RxList<DocumentSnapshot> myRequests = RxList<DocumentSnapshot>();

  TextEditingController requestVehicleNameController = TextEditingController();
  TextEditingController requestSourceController = TextEditingController();
  TextEditingController requestDestinationNameController =
      TextEditingController();
  TextEditingController requestPickUpController = TextEditingController();
  TextEditingController requestDropController = TextEditingController();
  TextEditingController requestTimeController = TextEditingController();
  TextEditingController requestDateController = TextEditingController();
  TextEditingController requestIDController = TextEditingController();

  void extractDateTime(String dateTimeString) {
    try {
      List<String> dateTimeParts = dateTimeString.split(' ');

      // Extracting the date
      List<String> dateParts = dateTimeParts[0].split('-');
      String date =
          '${dateParts[2]}-${dateParts[1].padLeft(2, '0')}-${dateParts[0].padLeft(2, '0')}';
      requestDateController.text = date;

      // Extracting the time
      List<String> timeParts = dateTimeParts[1].split(':');
      String time =
          '${timeParts[0].padLeft(2, '0')}:${timeParts[1].padLeft(2, '0')}';
      requestTimeController.text = time;
    } catch (e) {
      // Handle any unexpected errors that may occur during extraction
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

  Future<void> sendRequestsToOwners(String vehicleName) async {
    try {
      final QuerySnapshot vehicleSnapshot =
          await FirebaseFirestore.instance.collection('vehicles').get();

      final List<String> ownerIds = vehicleSnapshot.docs
          .where((doc) => doc['vehicleName'] == vehicleName)
          .map((doc) {
        final String ownerId = doc['ownerID'].toString();
        final CollectionReference ownersCollection =
            FirebaseFirestore.instance.collection('owners');
        final DocumentReference ownerDocRef = ownersCollection.doc(ownerId);
        final CollectionReference requestCollection =
            ownerDocRef.collection('requests');

        extractDateTime(requestPickUpController.text);

        // Provide the fields to be saved in the subcollection
        requestCollection.doc(requestIDController.text).set({
          'vehicleName': requestVehicleNameController.text,
          'requestTime': requestTimeController.text,
          'requestDate': requestDateController.text,
          'requestFrom': requestSourceController.text,
          'requestTo': requestDestinationNameController.text,
          'requestID': requestIDController.text,
          // Add more fields as needed
        });

        return ownerId;
      }).toList();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  Future<void> fetchMyRequests(String currentUserId) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userId', isEqualTo: currentUserId)
          .get();

      // Store the documents in the bookingData list
      myRequests.assignAll(querySnapshot.docs);
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'No data found.',
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
      // Handle any errors that may occur during date parsing
      Fluttertoast.showToast(
        msg: 'Invalid date format.',
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

  Future<void> searchAndFetchDetails(String docId) async {
    try {
      // Query the "bookings" collection for the provided docId
      DocumentSnapshot bookingSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .doc(docId)
          .get();

      // Check if the booking document with the provided docId exists
      if (bookingSnapshot.exists) {
        // Fetch the ownerId and vehicleNumber from the booking document
        String ownerId = bookingSnapshot['ownerID'];
        String vehicleNumber = bookingSnapshot['vehicleNumber'];

        mainController.assignedOwnerIDController.text = ownerId;

        // Query the "vehicles" collection for matching ownerId and vehicleNumber
        QuerySnapshot vehicleSnapshot = await FirebaseFirestore.instance
            .collection('vehicles')
            .where('ownerID', isEqualTo: ownerId)
            .where('vehicleNumber', isEqualTo: vehicleNumber)
            .get();

        // Check if a matching vehicle document exists
        if (vehicleSnapshot.docs.isNotEmpty) {
          // Retrieve the first matching vehicle document
          DocumentSnapshot vehicleDocSnapshot = vehicleSnapshot.docs.first;

          // Fetch the desired fields from the vehicle document
          // ...
          mainController.assignedVehicleNumberController.text =
              vehicleDocSnapshot['vehicleNumber'];
          mainController.assignedOwnerNameController.text =
              vehicleDocSnapshot['ownerName'];
          mainController.assignedOwnerPhoneNumberController.text =
              vehicleDocSnapshot['ownerPhoneNumber'];
        } else {
          Fluttertoast.showToast(
            msg: 'Vehicle not found.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[600],
            textColor: Colors.black,
            fontSize: 16.0,
          );
          // Handle the case when no matching vehicle is found
        }
      } else {
        Fluttertoast.showToast(
          msg: 'No data found.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[600],
          textColor: Colors.black,
          fontSize: 16.0,
        );
        // Handle the case when no matching booking is found
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  Future<void> updateOnRideField(String ownerId, String vehicleNumber) async {
    try {
      // Query the "vehicles" collection for matching ownerId and vehicleNumber
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('ownerID', isEqualTo: ownerId)
          .where('vehicleNumber', isEqualTo: vehicleNumber)
          .get();

      // Check if a matching vehicle document exists
      if (snapshot.docs.isNotEmpty) {
        // Get the first matching document
        DocumentSnapshot document = snapshot.docs.first;

        // Get the document ID
        String docId = document.id;

        // Update the on_ride field to false
        await FirebaseFirestore.instance
            .collection('vehicles')
            .doc(docId)
            .update({'onRide': false});
      } else {
        Fluttertoast.showToast(
          msg: 'Vehicle not found.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[600],
          textColor: Colors.black,
          fontSize: 16.0,
        );
        // Handle the case when no matching vehicle is found
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Error occurred.',
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
