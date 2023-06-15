import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import'package:get/get.dart';

class OwnerRequestHandler extends GetxController {

  final user = FirebaseAuth.instance.currentUser;

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

  Future<void> transferRequestToBookings(DocumentReference requestDocRef, String requestId) async {
    try {
      // Retrieve the document snapshot from the "requests" collection
      DocumentSnapshot requestDocSnapshot = await requestDocRef.get();
      print(requestDocRef.toString());
      print(requestDocSnapshot);

      // Transfer the document to the "bookings" collection with additional fields
      await FirebaseFirestore.instance.collection('bookings').doc(requestId).set({
        'status': requestDocSnapshot['status'],
        'vehicleName': requestDocSnapshot['vehicleName'],
        'source': requestDocSnapshot['source'],
        'destination': requestDocSnapshot['destination'],
        'pickupDateTime': requestDocSnapshot['pickupDateTime'],
        'returnDateTime': requestDocSnapshot['returnDateTime'],
        'purpose': requestDocSnapshot['purpose'],
        'delivery': requestDocSnapshot['delivery'],
        'userId': requestDocSnapshot['userId'],
        'requestId': requestId,
        'ownerId': user?.uid,
        // Include other fields from the request document as needed
      });

      print('Document transferred to the "bookings" collection successfully!');
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