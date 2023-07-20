import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminPaymentsController extends GetxController {
  RxList<String> carnames = ['Audi', 'Ferrari', 'Mercedes-Benz', 'Hyundai'].obs;
  RxList<String> model = ['A4', 'F40', 'S-class', 'i20'].obs;
  RxList<String> carnumber =
      ['TS28BZ1122', 'TS28BZ2234', 'TS28BZ5124', 'TS28BZ6632'].obs;
  RxList<String> ownernames = ['Ragesh', 'Rajesh', 'Suresh', 'Ramesh'].obs;
  RxList<String> phnos =
      ['+919874563211', '+919632145870', '+919852364177', '+919456871023'].obs;

  RxList<String> customernames = ['Suresh', 'Ramesh', 'Mahesh', 'Ragesh'].obs;

  RxList<String> bookingids =
      ['BKID12345', 'BKID89547', 'BKID21456', 'BKID22554'].obs;
  RxList<String> transactionids =
      ['TNID7895', 'TNID8855', 'TNID9568', 'TNID5466'].obs;

  final RxList<DocumentSnapshot> paymentData = RxList<DocumentSnapshot>();
  // Fetch customer names beforehand

  Future<void> fetchBookingData() async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query the "booking" collection
      QuerySnapshot querySnapshot = await firestore.collection('bookings').get();

      // Store the documents in the bookingData list
      paymentData.assignAll(querySnapshot.docs);

      print(paymentData);

      print('Booking data fetched successfully!');
    } catch (e) {
      print('Error fetching booking data: $e');
    }
  }

  Future<String?> fetchCustomerName(String userId) async {
    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch the document from the customers collection where docId == userId
      DocumentSnapshot snapshot = await firestore.collection('customers').doc(userId).get();

      // Check if the document exists
      if (snapshot.exists) {
        // Retrieve the field value and return it
        return snapshot.get('name'); // Replace 'fieldName' with the actual field name you want to retrieve
      } else {
        // Document does not exist
        return null;
      }
    } catch (e) {
      // Error occurred while fetching the document
      print('Error fetching field value: $e');
      return null;
    }
  }

  Future<String?> fetchOwnerName(String ownerId) async {
    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch the document from the customers collection where docId == userId
      DocumentSnapshot snapshot = await firestore.collection('owners').doc(ownerId).get();

      // Check if the document exists
      if (snapshot.exists) {
        // Retrieve the field value and return it
        return snapshot.get('name'); // Replace 'fieldName' with the actual field name you want to retrieve
      } else {
        // Document does not exist
        return null;
      }
    } catch (e) {
      // Error occurred while fetching the document
      print('Error fetching field value: $e');
      return null;
    }
  }


  Future<String?> fetchOwnerPhoneNumber(String ownerId) async {
    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch the document from the customers collection where docId == userId
      DocumentSnapshot snapshot = await firestore.collection('owners').doc(ownerId).get();

      // Check if the document exists
      if (snapshot.exists) {
        // Retrieve the field value and return it
        return snapshot.get('phone_number'); // Replace 'fieldName' with the actual field name you want to retrieve
      } else {
        // Document does not exist
        return null;
      }
    } catch (e) {
      // Error occurred while fetching the document
      print('Error fetching field value: $e');
      return null;
    }
  }


}