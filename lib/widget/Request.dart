import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/controllers/main_controller.dart';
import 'package:need_moto/functions.dart';
import 'package:need_moto/functions.dart';
import 'package:need_moto/screens/Request_Pending.dart';
import 'package:need_moto/widget/car.dart';

import '../controllers/booking_controller.dart';
import '../screens/ReqAccept.dart';

class Request extends StatelessWidget {
  final String imgUrl;
  final String vehicleName;
  final String seats;
  final String average;
  final String kpml;
  final String type;
  final String ownerName;
  final String ownerPhoneNumber;
  final String vehiclePlateNumber;
  final String base_12;
  final String base_24;
  final String pricePerKmCust;
  final String pricerPerHourCust;



  String vehicleLocation;
  String source;
  String destination;
  String pickupDateTime;
  String returnDateTime;
  String delivery;
  String purpose;

  Request(
      {
      required this.imgUrl,
      required this.vehicleName,
      required this.seats,
      required this.average,
      required this.kpml,
      required this.type,
      required this.ownerName,
      required this.ownerPhoneNumber,
      required this.delivery,
      required this.purpose,
      required this.returnDateTime,
      required this.pickupDateTime,
      required this.source,
      required this.destination,
      required this.vehicleLocation,
      required this.vehiclePlateNumber,
      required this.pricePerKmCust,
      required this.pricerPerHourCust,
      required this.base_12,
      required this.base_24,
      });


  MainController mainController = Get.find();

  double totalPrice = 0.0;

  void storeUserRequestData() {
    // Get the current user ID
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // Generate a timestamp
    DateTime currentTime = DateTime.now();
    String timestamp = currentTime.millisecondsSinceEpoch.toString();

    // Create the document ID by combining the user ID and timestamp
    String documentId = '$currentUserId-$timestamp';

    // Create a reference to the document in the "users" collection
    DocumentReference userRef =
    FirebaseFirestore.instance.collection('bookings').doc(documentId);

    // Define the data to be stored in the document
    Map<String, dynamic> userData = {
      // Add your desired fields and values here
      'vehicleNumber': vehiclePlateNumber,
      'vehicleName': vehicleName,
      'source': source,
      'destination': destination,
      'pickupDateTime': pickupDateTime,
      'returnDateTime': returnDateTime,
      'purpose': purpose,
      'delivery': delivery,
      'status': mainController.requestStatusController.text,
      'userId': currentUserId,
      'vehicleNeedFromLocation': vehicleLocation,
    };

    // Store the data in the Firestore document
    userRef
        .set(userData)
        .then((value) {
      // Document created successfully
      // You can add any additional actions or navigate to another screen here
      print("made request");
    })
        .catchError((error) {
      // An error occurred while creating the document
      // Handle the error appropriately
      print("couldn't make request");
    });
  }
  void calculateRentalPrice(double base_12, double base_24, double pricePerHourCust, double pricePerKmCust) {

    double basePrice;
    double distanceLimit;
    double? numberOfExtraHours = double.tryParse(mainController.extraHoursController.text);
    if (numberOfExtraHours == null) {
      print('Invalid value for numberOfExtraHours');
      return;
    }

    double? distance = double.tryParse(mainController.distanceController.text);
    if (distance == null) {
      print('Invalid value for distance');
      return;
    }

    double? userChoiceHours = double.tryParse(mainController.userChoiceHoursController.text);
    if (userChoiceHours == null) {
      print('Invalid value for userChoiceHours');
      return;
    }

    // Set base price and distance limit based on conditions
    if (userChoiceHours == 12) {
      basePrice = base_12;
    } else {
      basePrice = base_24;
    }

    if (userChoiceHours == 12) {
      distanceLimit = 150.0;
    } else {
      distanceLimit = 350.0;
    }

    double extraHoursCost = numberOfExtraHours * pricePerHourCust;
    double distanceCost = (distance - distanceLimit) * pricePerKmCust;

    double totalCost = basePrice + extraHoursCost + distanceCost;
    print(totalCost);
    mainController.totalPriceController.text  = totalCost.toString();
    print(mainController.totalPriceController.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Car(imgUrl: imgUrl, vehicleName: vehicleName),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Specifications',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                seats,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Seats',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                average,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Km/h',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                kpml,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'KMPL',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                type,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Owner Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: [
                      Container(
                          width: 150,
                          height: 20,
                          child: Text(
                            ownerName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          )),
                      Container(
                          width: 150,
                          height: 15,
                          child: Text(
                            ownerPhoneNumber,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.all(1),
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  storeUserRequestData();
                  // print(double.parse(base_12));
                  // print(double.parse(base_24));
                  // print(double.parse(pricerPerHourCust));
                  // print(double.parse(pricePerKmCust));
                  //  calculateRentalPrice(
                  //     double.parse(base_12),
                  //     double.parse(base_24),
                  //     double.parse(pricerPerHourCust),
                  //     double.parse(pricePerKmCust));
                  try {
                    double parsedBase12 = double.parse(base_12);
                    double parsedBase24 = double.parse(base_24);
                    double parsedPricePerHourCust = double.parse(pricerPerHourCust);
                    double parsedPricePerKmCust = double.parse(pricePerKmCust);

                    calculateRentalPrice(parsedBase12, parsedBase24, parsedPricePerHourCust, parsedPricePerKmCust);
                  } catch (e) {
                    print('Error parsing double: $e');
                  }

                  print('called');

                  // BookingColntroller.instance.booking(
                  //   source,
                  //   destination,
                  //   pickupDateTime,
                  //   returnDateTime,
                  //   delivery,
                  //   purpose,
                  // );

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReqAccept(
                            vehicleLocation: vehicleLocation,
                            source: source,
                            destination: destination,
                            pickupDateTime: pickupDateTime,
                            returnDateTime: returnDateTime,
                            delivery: delivery,
                            purpose: purpose,
                            ownerName: ownerName,
                            ownerPhoneNumber: ownerPhoneNumber,
                            type: type,
                            vehicleNumber: vehiclePlateNumber,
                            vehicleName: vehicleName,
                            seats: seats,
                          )));
                },
                child: Text(
                  'Book Now',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            )));
  }
}
