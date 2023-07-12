import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/controllers/vehicleSubmitController.dart';
import 'package:need_moto/customer/screens/StarRating.dart';
import 'package:need_moto/customer/screens/points.dart';

class RateOwner extends StatefulWidget {

  String vehicleNumber;
  String ownerPhoneNumber;
  String ownerName;
  RateOwner({

    required this.vehicleNumber,
    required this.ownerName,
    required this.ownerPhoneNumber,
  });


  @override
  State<RateOwner> createState() => _RateOwnerState();
}

class _RateOwnerState extends State<RateOwner> {

  double customerRating = 0.0;
  int total_duration = 0;
  void onRated(double rating) {
    // Do something with the rating
    customerRating = rating;
    print(rating);
  }


  VehicleSubmitController vehicleSubmitController = Get.find();


  void addSubmittedVehicle() async {
    // Get the current user ID
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a reference to the "customers" collection
    CollectionReference customersCollection = firestore.collection('customers');

    // Create a reference to the current user's document
    DocumentReference userDocument = customersCollection.doc(currentUserId);

    // Generate a timestamp
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    // Create a reference to the "submittedvehicles" subcollection
    CollectionReference submittedVehiclesCollection =
    userDocument.collection('submittedVehicles');

    // Create a document ID using the parameter value and timestamp
    String documentId = '${widget.vehicleNumber}-$timestamp';

    // Create a new document in the "submittedvehicles" subcollection
    await submittedVehiclesCollection.doc(documentId).set({
      // Add your data fields here
      'reading': vehicleSubmitController.vehicleReadingController.text,
      'scratches': vehicleSubmitController.vehicleScratchController.text,
      'damages': vehicleSubmitController.vehicleDamageController.text,
      'fast_tag_amount': vehicleSubmitController.vehicleFastTagAmountController.text,
      'date_time': vehicleSubmitController.vehicleDateTimeOfHandoverController.text,
      'message': vehicleSubmitController.vehicleMessageController.text,
      'vehicleNumber': widget.vehicleNumber,
      'ownerPhoneNumber': widget.ownerPhoneNumber,
      'ownerName': widget.ownerName,
      'uid': currentUserId,
      'received_date': vehicleSubmitController.vehicleReceivedDateController.text,
      'received_time': vehicleSubmitController.vehicleReceivedTimeController.text,
      // 'total_duration': ,
      // // 'ride_km':,
      'submit_date': vehicleSubmitController.vehicleSubmitDateController.text,
      'submit_time': vehicleSubmitController.vehicleSubmitTimeController.text,
      // 'other_charges':,
      'cust_rating': customerRating.toString(),
      'cust_msg_to_driver': vehicleSubmitController.vehicleMessageToOwnerController.text,
      // ...
    });
  }

  @override
  Widget build(BuildContext context) {  
    int rating = 3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'RATING TO OWNER',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Container(
            child: Center(
              child: Column(children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.png'),
                  radius: 50, // Set the size of the avatar
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      '${widget.ownerName}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 25),
                    Text('Rate your Experience',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    StarRating(
                      maxRating: 5,
                      rating: 0,
                      onRated: onRated,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextField(
                        controller: vehicleSubmitController.vehicleMessageToOwnerController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: '',
                          hintText: 'Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade700],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8, left: 30, right: 30),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      onPressed: () {
                        Get.to(Points());
                      },
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
