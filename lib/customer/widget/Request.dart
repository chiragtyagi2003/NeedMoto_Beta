import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/Request_Controller.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/screens/RequestAccepted.dart';
import 'package:need_moto/customer/screens/Request_Pending.dart';
import 'package:need_moto/customer/screens/Request_Rejected.dart';
import 'package:need_moto/customer/widget/Car.dart';
import 'package:intl/intl.dart';
import 'dart:math';



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
  final bool isRotated;
  final String vehicleRating;
  final String bags;


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
      required this.isRotated,
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
      required this.vehicleRating,
      required this.bags,
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
          base_12: widget.base_12,
          base_24: widget.base_24,
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
        'vehicleType': mainController.vehicleTypeController.text,
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

  int calculateHoursDifference(String pickupDatetime, String returnDatetime) {
    // Parse the date strings into DateTime objects
    DateTime pickupDate = DateFormat('dd-MM-yyyy HH:mm').parse(pickupDatetime);
    DateTime returnDate = DateFormat('dd-MM-yyyy HH:mm').parse(returnDatetime);

    // Calculate the difference in hours
    Duration difference = returnDate.difference(pickupDate);
    int differenceInHours = difference.inHours;

    return differenceInHours;
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

      double? distance = double.tryParse(mainController.distanceController.text);
      print('DISTANCE: $distance');
      if (distance == null) {
        print('Invalid value for distance');
        return;
      }

      double? userChoiceHours = double.tryParse(mainController.userChoiceHoursController.text);
      print('USER CHOICE HOURS: $userChoiceHours');
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
      Size size = MediaQuery.of(context).size; //check the size of device
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40.0), //appbar size
            child: AppBar(
              bottomOpacity: 0.0,
              elevation: 0.0,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              leading: Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.05,
                ),
                child: SizedBox(
                  height: size.width * 0.01,
                  width: size.width * 0.1,
                  child: InkWell(
                    onTap: () {
                      Get.back(); //go back to home page
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: size.height * 0.025,
                    ),
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              leadingWidth: size.width * 0.15,
              title: Text(
                widget.vehicleName,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xff3b22a1),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
          ),
          extendBody: true,
          extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(
            child: Container(
              height: size.height,
              width: size.height,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 254, 252, 252),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 28.0),
                        child: ListView(
                          children: [
                            widget.isRotated
                                ? Hero(
                              tag: widget.rentalPrice,
                              child: Image.asset(
                                widget.imgUrl,
                                height: size.width * 0.5,
                                width: size.width * 0.8,
                                fit: BoxFit.contain,
                              ),
                            )
                                : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(pi),
                              child: Image.asset(
                                widget.imgUrl,
                                height: size.width * 0.5,
                                width: size.width * 0.8,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.type,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[800],
                                  size: size.width * 0.06,
                                ),
                                Text(
                                  widget.vehicleRating,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.yellow[800],
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.vehicleName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '₹${widget.rentalPrice}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '/day',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: size.width * 0.025,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.03,
                              ),
                              child: Text(
                                'Specifications',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.055,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: 120,
                              child: ListView(
                                scrollDirection: Axis.horizontal,

                                // mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  buildStat(
                                    Icons.speed,
                                    // UniconsLine.dashboard,
                                    '${widget.kpml} Kmph',
                                    'Speed',
                                    size,
                                  ),
                                  buildStat(
                                    Icons.car_rental,
                                    '${widget.average} km/l',
                                    'Mileage',
                                    size,
                                  ),
                                  buildStat(
                                    Icons.people,
                                    // UniconsLine.users_alt,
                                    'People',
                                    '( ${widget.seats} )',
                                    size,
                                  ),
                                  buildStat(
                                    Icons.shopping_bag,
                                    // UniconsLine.briefcase,
                                    'Bags',
                                    '( ${widget.bags} )',
                                    size,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.03,
                              ),
                              child: Text(
                                'Owner Details',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.055,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                height: size.height * 0.15,
                                width: size.width * 0.9,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.07,
                                        width: size.width * 0.15,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Align(
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.05,
                                          vertical: size.height * 0.015,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.ownerName,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: size.width * 0.05,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              widget.ownerPhoneNumber,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color:
                                                Colors.black.withOpacity(0.6),
                                                fontSize: size.width * 0.032,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: size.height * 0.01,
                    ),
                    child: SizedBox(
                      height: size.height * 0.07,
                      width: size.width,
                      child: InkWell(
                        onTap: () {

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
                                      RequestAccepted(
                                        //vehicleLocation: widget.vehicleLocation,
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
                                        base_12: widget.base_12,
                                        base_24: widget.base_24,
                                      )));

                          // Start the timer for the delay
                          const delayDuration = Duration(seconds: 30);// Adjust the delay duration as needed
                          Timer(delayDuration, () {
                            // After the delay, check the status of the booking document
                            final documentId =  requestController.requestIDController.text; // Replace with the actual document ID
                            checkBookingDocument(documentId);
                          });

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff3b22a1),
                          ),
                          child: Align(
                            child: Text(
                              'Book Now',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: size.height * 0.025,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

    }

  Padding buildStat(
      IconData icon,
      String title,
      String desc,
      Size size,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.015,
      ),
      child: SizedBox(
        height: size.width * 0.32,
        width: size.width * 0.28,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: size.width * 0.03,
              left: size.width * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Color(0xff3b22a1),
                  size: size.width * 0.08,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.width * 0.02,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

