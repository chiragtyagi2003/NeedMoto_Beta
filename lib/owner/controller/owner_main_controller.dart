import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:need_moto/owner/controller/scratches_dropdown.dart';

class OwnerMainController extends GetxController {
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController vehicleCompanyController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController vehicleCurrentReadingController =
      TextEditingController();
  TextEditingController vehicleRcNumberController = TextEditingController();
  TextEditingController vehiclePendingChallansController =
      TextEditingController();
  TextEditingController vehicleInsuranceController = TextEditingController();
  TextEditingController vehicleLocationController = TextEditingController();
  TextEditingController vehicleFuelTypeController = TextEditingController();

  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerPhoneNumberController = TextEditingController();

  // receive vehicle controllers
  ScratchesDropdownController ownerScratchController =
      ScratchesDropdownController();
  final TextEditingController ownerReadingController = TextEditingController();
  final TextEditingController ownerDamageController = TextEditingController();
  final TextEditingController ownerFastTagController = TextEditingController();
  final TextEditingController ownerMessageController = TextEditingController();
  final TextEditingController ownerOtherChargesController =
      TextEditingController();
  final TextEditingController ownerScratchesController =
      TextEditingController();
  TextEditingController dateInput = TextEditingController();

  // otp controllers
  TextEditingController otpDigit1Controller = TextEditingController();
  TextEditingController otpDigit2Controller = TextEditingController();
  TextEditingController otpDigit3Controller = TextEditingController();
  TextEditingController otpDigit4Controller = TextEditingController();
  TextEditingController otpStringController = TextEditingController();

  // feedback to rider controller
  TextEditingController ownerRatingToRiderController = TextEditingController();
  TextEditingController ownerMessageToCustomerController =
      TextEditingController();

  Future<void> saveVehicleDataToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    final collectionRef = FirebaseFirestore.instance.collection('vehicles');

    final vehicleData = {
      'vehicleName': vehicleNameController.text,
      'brandName': vehicleCompanyController.text,
      'vehicleNumber': vehicleNumberController.text,
      'model': vehicleModelController.text,
      'vehicleCurrentReading': vehicleCurrentReadingController.text,
      'vehicleRcNumber': vehicleRcNumberController.text,
      'vehiclePendingChallans': vehiclePendingChallansController.text,
      'vehicleInsurance': vehicleInsuranceController.text,
      'vehicleLocation': vehicleLocationController.text,
      'adminApproval': false,
      'onRide': false,
      'owner_on_ride': true,
      'ownerName': ownerNameController.text,
      'ownerPhoneNumber': ownerPhoneNumberController.text,
      'ownerID': user?.uid,
      'type': vehicleFuelTypeController.text,
    };

    try {
      await collectionRef
          .add(vehicleData); // Use add method to auto-generate document ID
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error. Vehicle not added.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  Future<void> fetchData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('owners')
                .doc(user.uid)
                .get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data()!;
          ownerNameController.text = data['name'];
          ownerPhoneNumberController.text = data['phone_number'];
        }
      }
    } catch (e) {
      // TODO
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

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> fetchVehicles() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('ownerID', isEqualTo: user!.uid)
          .where('adminApproval', isEqualTo: true)
          .get();

      print(querySnapshot.docs.length);
      return querySnapshot.docs;
    } catch (e) {
      // TODO
      Fluttertoast.showToast(
        msg: "Error. No vehicles found.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return []; // Return an empty list in case of an error
    }
  }

  // Get the current user's ID
  String getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return 'qFm8nd1BODSFfJLEsGNFLzjbOiN2';
  }

  Future<void> updateVehicleField(String ownerId, String vehicleNumber) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('vehicle')
          .where('ownerId', isEqualTo: ownerId)
          .where('vehicleNumber', isEqualTo: vehicleNumber)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('Vehicle not found');
      }

      final DocumentSnapshot document = snapshot.docs.first;

      // Get the document ID
      String docId = document.id;

      // // Get the current value of 'owner_on_ride'
      bool currentValue = document['owner_on_ride'];

      // // Toggle the value of 'owner_on_ride'
      bool newValue = !currentValue;

      // Update the 'owner_on_ride' field
      await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(docId)
          .update({'owner_on_ride': newValue});
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error. No vehicles found.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  void addReceivedVehicle(String bookingId) async {
    // Get the Firestore instance
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a reference to the bookings collection
      CollectionReference submittedVehiclesCollection =
          firestore.collection('bookings');

      // Create a document ID using the parameter value and timestamp
      String documentId = bookingId;

      // update fields in bookings
      await submittedVehiclesCollection.doc(documentId).update({
        // Add your data fields here
        'owner_reading': ownerReadingController.text,
        'owner_scratches': ownerScratchController,
        'owner_damages': ownerDamageController.text,
        'owner_fast_tag_amount': ownerFastTagController.text,
        'owner_other_charges': ownerOtherChargesController.text,
        'owner_message_controller': ownerMessageController.text,
        'owner_message_to_customer': ownerMessageToCustomerController.text,
        'owner_rating_to_rider': ownerRatingToRiderController.text,

        // change status of received_by_owner
        'received_by_owner': false,
      });
    } catch (e) {
      // TODO
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
