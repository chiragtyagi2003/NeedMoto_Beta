import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/Request_Controller.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/controllers/vehicleSubmitController.dart';
import 'package:need_moto/customer/screens/StarRating.dart';
import 'package:need_moto/customer/screens/points.dart';

class RateOwner extends StatefulWidget {
  final String vehicleNumber;
  final String ownerPhoneNumber;
  final String ownerName;
  const RateOwner({
    super.key,
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
  }

  VehicleSubmitController vehicleSubmitController = Get.find();
  RequestController requestController = Get.find();
  MainController mainController = Get.find();

  void addSubmittedVehicle() async {
    try {
      // Get the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a reference to the bookings collection
      CollectionReference submittedVehiclesCollection =
          firestore.collection('bookings');

      // Create a document ID using the parameter value and timestamp
      String documentId = requestController.requestIDController.text;

      // update fields in bookings
      await submittedVehiclesCollection.doc(documentId).update({
        // Add your data fields here
        // ...
        // update ride status in booking
        'ongoing_ride': false,
        // ...
      });

      // change status of the vehicle
      await requestController.updateOnRideField(
          mainController.assignedOwnerIDController.text,
          mainController.assignedVehicleNumberController.text);
    } catch (e) {
      // Handle any errors that occur during updating submitted vehicle data or changing vehicle status
      Fluttertoast.showToast(
        msg: 'Error.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
      // You can show an error message to the user or handle the error in another way.
    }
  }

  @override
  Widget build(BuildContext context) {
    int rating = 3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'RATING TO OWNER',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        leading: IconButton(
          icon: const Icon(
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
          child: Center(
            child: Column(children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/profile.png'),
                radius: 50, // Set the size of the avatar
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Text(
                    widget.ownerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text('Rate your Experience',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  StarRating(
                    maxRating: 5,
                    rating: 0,
                    onRated: onRated,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextField(
                      controller: vehicleSubmitController
                          .vehicleMessageToOwnerController,
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      addSubmittedVehicle();

                      Get.to(const Points());
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 30, right: 30),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
