
import 'dart:async';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/controllers/Request_Controller.dart';
import 'package:need_moto/controllers/main_controller.dart';
import 'package:need_moto/functions.dart';
import 'package:need_moto/functions.dart';
import 'package:need_moto/screens/RequestAccepted.dart';
import 'package:need_moto/screens/Request_Pending.dart';
import 'package:need_moto/widget/car.dart';
import '../controllers/booking_controller.dart';
import '../screens/ReqAccept.dart';
import '../screens/Request_Rejected.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';


class Request extends StatefulWidget {
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
  final double rentalPrice;

  String vehicleLocation;
  String source;
  String destination;
  String pickupDateTime;
  String returnDateTime;
  String delivery;
  String purpose;

  static Request? _instance;

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
      required this.rentalPrice,
      }){
        _instance = this;
      }

  String storeRequestID = "";
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  // data structure to store the notification id and phone number
  Map<String, String> notificationIdToPhoneNumber = {};


  static Request get instance => _instance!;


  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  MainController mainController = Get.find();

  double totalPrice = 0.0;

  RequestController requestController = Get.find();

  void setControllerValues() {
    requestController.requestVehicleNameController.text = widget.vehicleName;
    requestController.requestSourceController.text = widget.source;
    requestController.requestDropController.text = widget.returnDateTime;
    requestController.requestPickUpController.text = widget.pickupDateTime;
    requestController.requestDestinationNameController.text =
        widget.destination;
  }

  void checkBookingDocument(String documentId) async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .doc(documentId)
          .get();

      if (snapshot.exists) {
        // Document exists, navigate to a certain page
        // Replace 'YourPage()' with the desired page widget or navigation logic
        Get.to(RequestAccepted(
          // vehicleLocation: vehicleLocation,
          source: widget.source,
          destination: widget.destination,
          pickupDateTime: widget.pickupDateTime,
          returnDateTime: widget.returnDateTime,
          delivery: widget.delivery,
          purpose: widget.purpose,
          ownerName: widget.ownerName,
          ownerPhoneNumber: widget.ownerPhoneNumber,
          type: widget.type,
          vehicleNumber: widget.vehiclePlateNumber,
          vehicleName: widget.vehicleName,
          seats: widget.seats,
          rentalPrice: widget.rentalPrice,
        ));
      } else {
        Get.to(RequestRejected(
          // vehicleLocation: vehicleLocation,
          source: widget.source,
          destination: widget.destination,
          pickupDateTime: widget.pickupDateTime,
          returnDateTime: widget.returnDateTime,
          delivery: widget.delivery,
          purpose: widget.purpose,
          ownerName: widget.ownerName,
          ownerPhoneNumber: widget.ownerPhoneNumber,
          type: widget.type,
          vehicleNumber: widget.vehiclePlateNumber,
          vehicleName: widget.vehicleName,
          seats: widget.seats,
          rentalPrice: widget.rentalPrice,
        ));
        // Document does not exist
        // Handle the case when the document does not exist, if needed
      }
    } catch (e) {
      // Handle error
      print('Error checking booking document: $e');
    }
  }


    void storeUserRequestData() {
      // Get the current user ID
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;

      // Generate a timestamp
      DateTime currentTime = DateTime.now();
      String timestamp = currentTime.millisecondsSinceEpoch.toString();

      // Create the document ID by combining the user ID and timestamp
      String documentId = '$currentUserId-$timestamp';
      requestController.requestIDController.text = documentId;

      // Create a reference to the document in the "users" collection
      DocumentReference userRef =
      FirebaseFirestore.instance.collection('requests').doc(documentId);

      // Define the data to be stored in the document
      Map<String, dynamic> userData = {
        // Add your desired fields and values here
        //'vehicleNumber': widget.vehiclePlateNumber,
        'vehicleName': widget.vehicleName,
        'source': widget.source,
        'destination': widget.destination,
        'pickupDateTime': widget.pickupDateTime,
        'returnDateTime': widget.returnDateTime,
        'purpose': widget.purpose,
        'delivery': widget.delivery,
        'status': mainController.requestStatusController.text,
        'userId': currentUserId,
        //'vehicleNeedFromLocation': widget.vehicleLocation,
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

      setState(() {
        Request.instance.storeRequestID = userRef.id;
      });
    }

    void calculateRentalPrice(double base_12, double base_24,
        double pricePerHourCust, double pricePerKmCust) {
      double basePrice;
      double distanceLimit;
      double? numberOfExtraHours = double.tryParse(
          mainController.extraHoursController.text);
      if (numberOfExtraHours == null) {
        print('Invalid value for numberOfExtraHours');
        return;
      }

      double? distance = double.tryParse(
          mainController.distanceController.text);
      if (distance == null) {
        print('Invalid value for distance');
        return;
      }

      double? userChoiceHours = double.tryParse(
          mainController.userChoiceHoursController.text);
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
      mainController.totalPriceController.text = totalCost.toString();
      print(mainController.totalPriceController.text);
    }


    @override
    void initState() {
      // TODO: implement initState
      // startListeningNotificationEvents();
      // print('now listening to notification events');
      setControllerValues();
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Car(imgUrl: widget.imgUrl, vehicleName: widget.vehicleName),
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
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
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
                                  widget.seats,
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
                                  widget.average,
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
                                  widget.kpml,
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
                            child: Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    widget.type,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
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
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
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
                              widget.ownerName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )),
                        Container(
                            width: 150,
                            height: 15,
                            child: Text(
                              widget.ownerPhoneNumber,
                              style: TextStyle(fontSize: 14, color: Colors
                                  .grey),
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black),
                  onPressed: () {
                    storeUserRequestData();
                    try {
                      double parsedBase12 = double.parse(widget.base_12);
                      double parsedBase24 = double.parse(widget.base_24);
                      double parsedPricePerHourCust = double.parse(
                          widget.pricerPerHourCust);
                      double parsedPricePerKmCust = double.parse(
                          widget.pricePerKmCust);

                      calculateRentalPrice(
                          parsedBase12, parsedBase24, parsedPricePerHourCust,
                          parsedPricePerKmCust);
                    } catch (e) {
                      print('Error parsing double: $e');
                    }

                    print('called');

                    requestController.sendRequestsToOwners(widget.vehicleName);


                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RequestPending(
                                  vehicleLocation: widget.vehicleLocation,
                                  source: widget.source,
                                  destination: widget.destination,
                                  pickupDateTime: widget.pickupDateTime,
                                  returnDateTime: widget.returnDateTime,
                                  delivery: widget.delivery,
                                  purpose: widget.purpose,
                                  ownerName: widget.ownerName,
                                  ownerPhoneNumber: widget.ownerPhoneNumber,
                                  type: widget.type,
                                  vehicleNumber: widget.vehiclePlateNumber,
                                  vehicleName: widget.vehicleName,
                                  seats: widget.seats,
                                  rentalPrice: widget.rentalPrice,
                                )));

                            // Start the timer for the delay
                            const delayDuration = Duration(seconds: 10); // Adjust the delay duration as needed
                            Timer(delayDuration, () {
                              // After the delay, check the status of the booking document
                              final documentId =  requestController.requestIDController.text; // Replace with the actual document ID
                              checkBookingDocument(documentId);
                            });

                  },
                  child: Text(
                    'Book Now',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              )));
    }
  }
