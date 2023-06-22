import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class RequestController extends GetxController {
  RxList productData = [].obs;
  var status = ''.obs;

  final RxList<DocumentSnapshot> myRequests = RxList<DocumentSnapshot>();

  TextEditingController requestVehicleNameController = TextEditingController();
  TextEditingController requestSourceController = TextEditingController();
  TextEditingController requestDestinationNameController = TextEditingController();
  TextEditingController requestPickUpController = TextEditingController();
  TextEditingController requestDropController = TextEditingController();
  TextEditingController requestTimeController = TextEditingController();
  TextEditingController requestDateController = TextEditingController();
  TextEditingController requestIDController = TextEditingController();

  void extractDateTime(String dateTimeString) {
    List<String> dateTimeParts = dateTimeString.split(' ');

    // Extracting the date
    List<String> dateParts = dateTimeParts[0].split('-');
    String date =
        '${dateParts[2]}-${dateParts[1].padLeft(2, '0')}-${dateParts[0].padLeft(2, '0')}';
    requestDateController.text = date;
    print('Request Date: $date');

    // Extracting the time
    List<String> timeParts = dateTimeParts[1].split(':');
    String time =
        '${timeParts[0].padLeft(2, '0')}:${timeParts[1].padLeft(2, '0')}';
    requestTimeController.text = time;
    print('request time: $time');
  }



  @override
  void onInit() {
    super.onInit();
  }

  Future<void> sendRequestsToOwners(String vehicleName) async {
    try {
      final QuerySnapshot vehicleSnapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .get();

      final List<String> ownerIds = vehicleSnapshot.docs
          .where((doc) => doc['vehicleName'] == vehicleName)
          .map((doc) {
        final String ownerId = doc['ownerID'].toString();
        final CollectionReference ownersCollection =
        FirebaseFirestore.instance.collection('owners');
        final DocumentReference ownerDocRef = ownersCollection.doc(ownerId);
        final CollectionReference requestCollection = ownerDocRef.collection('requests');

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
      })
          .toList();

    } catch (e) {
      print('Error retrieving owner IDs: $e');
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

      print(myRequests);

      print('My Booking data fetched successfully!');
    } catch (e) {
      print('Error fetching bookings: $e');

    }
  }

  String calculateHoursDifference(String pickupDatetime, String returnDatetime) {
    // Parse the date strings into DateTime objects
    DateTime pickupDate = DateFormat('dd-MM-yyyy HH:mm').parse(pickupDatetime);
    DateTime returnDate = DateFormat('dd-MM-yyyy HH:mm').parse(returnDatetime);

    // Calculate the difference in hours
    Duration difference = returnDate.difference(pickupDate);
    int differenceInHours = difference.inHours;

    String finalRequestTime = differenceInHours.toString();

    return finalRequestTime;
  }

}
