import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';

class OwnerRequestHandler extends GetxController {

  final user = FirebaseAuth.instance.currentUser;
  MainController mainController = Get.find();

  Future<void> updateStatusField(String status, String requestId) async {
    try {
      // Get a reference to the document in the "requests" collection
      DocumentReference requestDocRef =
      FirebaseFirestore.instance.collection('requests').doc(requestId);

      // Update the value of the "status" field
      await requestDocRef.update({'status': status});

      print('Status field updated successfully!');


      // Transfer the request to the "bookings" collection
      await transferRequestToBookings(requestDocRef, requestId);

      // Delete the document from the "requests" collection
      await requestDocRef.delete();

      print('Document deleted from the "requests" collection successfully!');
    } catch (error) {
      print('Error updating status field: $error');
    }
  }

  // Future<void> transferRequestToBookings(DocumentReference requestDocRef, String requestId) async {
  //   try {
  //     // Retrieve the document snapshot from the "requests" collection
  //     DocumentSnapshot requestDocSnapshot = await requestDocRef.get();
  //     print(requestDocRef.toString());
  //     print(requestDocSnapshot);
  //
  //     // Transfer the document to the "bookings" collection with additional fields
  //     await FirebaseFirestore.instance.collection('bookings').doc(requestId).set({
  //       'status': requestDocSnapshot['status'],
  //       'vehicleName': requestDocSnapshot['vehicleName'],
  //       'source': requestDocSnapshot['source'],
  //       'destination': requestDocSnapshot['destination'],
  //       'pickupDateTime': requestDocSnapshot['pickupDateTime'],
  //       'returnDateTime': requestDocSnapshot['returnDateTime'],
  //       'purpose': requestDocSnapshot['purpose'],
  //       'delivery': requestDocSnapshot['delivery'],
  //       'userId': requestDocSnapshot['userId'],
  //       'requestId': requestId,
  //       'ownerId': user?.uid,
  //       'pay_status': false,
  //       // Include other fields from the request document as needed
  //     });
  //
  //     print('Document transferred to the "bookings" collection successfully!');
  //   } catch (error) {
  //     print('Error transferring document to "bookings" collection: $error');
  //   }
  // }

  Future<void> transferRequestToBookings(DocumentReference requestDocRef, String requestId) async {
    try {
      // Retrieve the document snapshot from the "requests" collection
      DocumentSnapshot requestDocSnapshot = await requestDocRef.get();
      print(requestDocRef.toString());
      print(requestDocSnapshot);

      // Query the "vehicles" collection for a matching vehicle
      QuerySnapshot vehicleQuerySnapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('ownerID', isEqualTo: user?.uid) // Replace with the actual owner ID
          .where('vehicleName', isEqualTo: requestDocSnapshot['vehicleName'])
          .where('on_ride', isEqualTo: false)
          .get();

      // Check if a matching vehicle document exists
      // this will also handle if all the vehicle
      // of requested type are on ride
      // as in that case on_ride will be true

      /// TO DO : DO NOT SEND REQUEST TO THAT OWNER WHOSE ALL VEHICLES ARE ON RIDE
      /// AT THE MOMENT
      ///
      if (vehicleQuerySnapshot.docs.isNotEmpty) {
        // Get the first document from the query result
        DocumentSnapshot vehicleDocSnapshot = vehicleQuerySnapshot.docs.first;

        // Update the "on_ride" field of the vehicle document to true
        String vehicleDocId = vehicleDocSnapshot.id;
        await FirebaseFirestore.instance.collection('vehicles').doc(vehicleDocId).update({
          'on_ride': true,
        });

        // Fetch the vehicle number
        String fetchedVehicleNumber = vehicleDocSnapshot['vehicleNumber'];

        // Transfer the document to the "bookings" collection with additional fields
        await FirebaseFirestore.instance.collection('bookings').doc(requestId).set({
          'status': requestDocSnapshot['status'],
          'vehicleName': requestDocSnapshot['vehicleName'],
          'vehicleNumber': fetchedVehicleNumber,
          'source': requestDocSnapshot['source'],
          'destination': requestDocSnapshot['destination'],
          'pickupDateTime': requestDocSnapshot['pickupDateTime'],
          'returnDateTime': requestDocSnapshot['returnDateTime'],
          'purpose': requestDocSnapshot['purpose'],
          'delivery': requestDocSnapshot['delivery'],
          'userId': requestDocSnapshot['userId'],
          'requestId': requestId,
          'ownerID': user?.uid,
          'pay_status': false,
          // Include other fields from the request document as needed
        });

        //pass the ownerID and vehicle number to customer interface

        print('Document transferred to the "bookings" collection successfully!');
      } else {
        print('No matching vehicle found.');
        // Handle the case when no matching vehicle is found
      }
    } catch (error) {
      print('Error transferring document to "bookings" collection: $error');
    }
  }

  void handleDecline(String requestId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('owners')
            .doc(user.uid)
            .collection('requests')
            .doc(requestId)
            .delete();
        // Handle success or show a notification
      }
    } catch (e) {
      // Handle error
      print('Error declining request: $e');
    }
  }

  void handleAccept(String requestId) async {
    try {
      await updateStatusField('accepted', requestId);
      final QuerySnapshot ownersSnapshot = await FirebaseFirestore.instance
          .collection('owners')
          .get();

      for (final ownerDoc in ownersSnapshot.docs) {
        final ownerRef = ownerDoc.reference;
        final requestRef =
        ownerRef.collection('requests').doc(requestId);
        await requestRef.delete();
      }

      // Handle success or show a notification
    } catch (e) {
      // Handle error
      print('Error accepting request: $e');
    }
  }



}