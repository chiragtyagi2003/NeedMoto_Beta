import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/Request_model.dart';
import '../screens/RequestAccepted.dart';
import '../screens/Request_Pending.dart';
import '../screens/Request_Rejected.dart';

class RequestController extends GetxController {
  RxList productData = [].obs;
  var status = ''.obs;

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
    // fatchData();
  }

  // void fatchData() {
  //   productData.assign(data(

  //       from: 'Kott bayam',
  //       to: 'Chittoor',
  //       pickupDate: '22-04-23',
  //       dropDate: '23-04-23',
  //       delivery: 'Pickup',
  //       purpose: 'Home'));
  //   debugPrint(productData[0].toString());
  // }

  // void change() {
  //   Widget getWidget(var status) {
  //     if (status == 'accepted') {
  //       return RequestAccepted();
  //     } else if (status == 'rejected') {
  //       return RequestRejected();
  //     } else {
  //       return RequestPending();
  //     }
  //   }
  // }

//   Widget getWidget(String status) {
//     if (status == 'accepted') {
//       return RequestAccepted();
//     } else if (status == 'rejected') {
//       return RequestRejected();
//     } else {
//       return RequestPending();
//     }
//   }

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

}
