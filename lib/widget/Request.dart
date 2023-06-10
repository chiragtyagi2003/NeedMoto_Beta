
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/controllers/main_controller.dart';
import 'package:need_moto/functions.dart';
import 'package:need_moto/functions.dart';
import 'package:need_moto/screens/RequestAccepted.dart';
import 'package:need_moto/screens/Request_Pending.dart';
import 'package:need_moto/widget/car.dart';

import '../controllers/booking_controller.dart';
import '../screens/ReqAccept.dart';
import '../screens/Request_Rejected.dart';

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


  static Request get instance => _instance!;

  Future<void> updateStatusField(String status) async {
    try {
      // Get a reference to the document in the "requests" collection
      DocumentReference requestDocRef =
      FirebaseFirestore.instance.collection('requests').doc(storeRequestID);

      // Update the value of the "status" field
      await requestDocRef.update({'status': status});

      print('Status field updated successfully!');


      // Transfer the request to the "bookings" collection
      await transferRequestToBookings(requestDocRef);

      // Delete the document from the "requests" collection
      await requestDocRef.delete();

      print('Document deleted from the "requests" collection successfully!');
    } catch (error) {
      print('Error updating status field: $error');
    }
  }

  Future<void> transferRequestToBookings(DocumentReference requestDocRef) async {
    try {
      // Retrieve the document snapshot from the "requests" collection
      DocumentSnapshot requestDocSnapshot = await requestDocRef.get();

      // Transfer the document to the "bookings" collection with additional fields
      await FirebaseFirestore.instance.collection('bookings').add({
        'status': requestDocSnapshot['status'],
        'vehicleName': vehicleName,
        'source': source,
        'destination': destination,
        'pickupDateTime': pickupDateTime,
        'returnDateTime': returnDateTime,
        'purpose': purpose,
        'delivery': delivery,
        'userId': currentUserId,
        'vehicleNeedFromLocation': vehicleLocation,

        // Include other fields from the request document as needed
      });

      print('Document transferred to the "bookings" collection successfully!');
    } catch (error) {
      print('Error transferring document to "bookings" collection: $error');
    }
  }

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  MainController mainController = Get.find();

  double totalPrice = 0.0;
  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
    }



  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    if (receivedAction.buttonKeyPressed == 'REJECT_BUTTON') {
      // Handle Reject button action here
      // This code will be executed when the Reject button is clicked
      // You can perform any desired action or logic
      try {
        Request.instance.updateStatusField('rejected');
        print('update field called');
        Get.to(RequestRejected(
          vehicleLocation: Request.instance.vehicleLocation,
          source: Request.instance.source,
          destination: Request.instance.destination,
          pickupDateTime: Request.instance.pickupDateTime,
          returnDateTime: Request.instance.returnDateTime,
          delivery: Request.instance.delivery,
          purpose: Request.instance.purpose,
          ownerName: Request.instance.ownerName,
          ownerPhoneNumber: Request.instance.ownerPhoneNumber,
          type: Request.instance.type,
          vehicleNumber: Request.instance.vehiclePlateNumber,
          vehicleName: Request.instance.vehicleName,
          seats: Request.instance.seats,
          rentalPrice: Request.instance.rentalPrice,

        ));
      } on Exception catch (e) {
        print(e.toString());
        // TODO
      }
    } else if (receivedAction.buttonKeyPressed == 'ACCEPT_BUTTON') {
      // Handle Accept button action here
      // This code will be executed when the Accept button is clicked
      // You can perform any desired action or logic
      try{
        String? phoneNumber = receivedAction.buttonKeyPressed;
        if (phoneNumber != null && phoneNumber.isNotEmpty) {
          // Handle the retrieved phone number here
          print('Phone number: $phoneNumber');
        }
        Request.instance.updateStatusField('accepted');
        print('update field called');
        Get.to(RequestAccepted(
          vehicleLocation: Request.instance.vehicleLocation,
          source: Request.instance.source,
          destination: Request.instance.destination,
          pickupDateTime: Request.instance.pickupDateTime,
          returnDateTime: Request.instance.returnDateTime,
          delivery: Request.instance.delivery,
          purpose: Request.instance.purpose,
          ownerName: Request.instance.ownerName,
          ownerPhoneNumber: Request.instance.ownerPhoneNumber,
          type: Request.instance.type,
          vehicleNumber: Request.instance.vehiclePlateNumber,
          vehicleName: Request.instance.vehicleName,
          seats: Request.instance.seats,
          rentalPrice: Request.instance.rentalPrice,
        ));
      } on Exception catch (e) {
        print(e.toString());
        // TODO
      }
    }

    // For background actions, you can add additional logic or tasks to execute
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      print('Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      //await executeLongTaskInBackground();
    } else {
      // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      //   '/notification-page',
      //       (route) =>
      //   (route.settings.name != '/notification-page') || route.isFirst,
      //   arguments: receivedAction,
      // );
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
      'vehicleNeedFromLocation': widget.vehicleLocation,
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

  Future<List<String>> getOwnerIds(String vehicleName) async {
    try {
      final QuerySnapshot vehicleSnapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .get();

      final List<String> ownerIds = vehicleSnapshot.docs
          .where((doc) => doc['vehicleName'] == vehicleName)
          .map((doc) => doc['ownerID'].toString())
          .toList();

      return ownerIds;
    } catch (e) {
      print('Error retrieving owner IDs: $e');
      return [];
    }
  }

  Future<List<String>> getPhoneNumbers(List<String> ownerIds) async {
    try {
      final QuerySnapshot ownersSnapshot = await FirebaseFirestore.instance
          .collection('owners')
          .where(FieldPath.documentId, whereIn: ownerIds)
          .get();

      final List<String> phoneNumbers = ownersSnapshot.docs
          .map((doc) => doc['phone_number'].toString())
          .toList();

      return phoneNumbers;
    } catch (e) {
      print('Error retrieving phone numbers: $e');
      return [];
    }
  }

  Future<void> sendNotifications(String vehicleName) async {
    print('sendNotifications called');
    // Get the owner IDs of the vehicles with the specified name.
    final ownerIds = await getOwnerIds(vehicleName);
    print('fetching owner Ids');
    print(ownerIds);

    // Get the phone numbers of the owners.
    final phonenumbers = await getPhoneNumbers(ownerIds);
    print('fetching phone numbers');
    print(phonenumbers);

    // Send notifications to the owners.
    for (var phonenumber in phonenumbers) {
      await _sendNotification(phonenumber, vehicleName);
      print('notification sent');
    }
  }

  Future<void> _sendNotification(String phoneNumber, String vehicleName) async {
    try {
      await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic Channel',
            channelDescription: 'This is the basic channel for app notifications.',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white,
          ),
        ],
      );

      final notificationId = DateTime.now().millisecondsSinceEpoch;

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 98989, // -1 is replaced by a random number
          channelKey: 'basic_channel',
          title: 'Vehicle Request',
          body: "Request has been made!",
          // bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
          // largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
          //'asset://assets/images/balloons-in-sky.jpg',
          // notificationLayout: NotificationLayout.BigPicture,
          payload: {'phoneNumber': phoneNumber},
        ),
        actionButtons: [
          // NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
          NotificationActionButton(
              key: 'REJECT_BUTTON',
              label: 'Reject',
              actionType: ActionType.SilentAction,
              isDangerousOption: true,
              color: Colors.red,

          ),
          NotificationActionButton(
            key: 'ACCEPT_BUTTON',
            label: 'Accept',
            actionType: ActionType.SilentAction,
            color: Colors.green,
          )
        ],

      );

  } catch (e) {
      print('Error sending notification: $e');
      // Handle the error accordingly
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    startListeningNotificationEvents();
    print('now listening to notification events');
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
                            widget.ownerName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          )),
                      Container(
                          width: 150,
                          height: 15,
                          child: Text(
                            widget.ownerPhoneNumber,
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
                    double parsedBase12 = double.parse(widget.base_12);
                    double parsedBase24 = double.parse(widget.base_24);
                    double parsedPricePerHourCust = double.parse(widget.pricerPerHourCust);
                    double parsedPricePerKmCust = double.parse(widget.pricePerKmCust);

                    calculateRentalPrice(parsedBase12, parsedBase24, parsedPricePerHourCust, parsedPricePerKmCust);
                  } catch (e) {
                    print('Error parsing double: $e');
                  }

                  print('called');

                  sendNotifications(widget.vehicleName);
                  print('notified');


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
                          builder: (context) => RequestPending(
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
                      // ReqAccept(
                      //       vehicleLocation: vehicleLocation,
                      //       source: source,
                      //       destination: destination,
                      //       pickupDateTime: pickupDateTime,
                      //       returnDateTime: returnDateTime,
                      //       delivery: delivery,
                      //       purpose: purpose,
                      //       ownerName: ownerName,
                      //       ownerPhoneNumber: ownerPhoneNumber,
                      //       type: type,
                      //       vehicleNumber: vehiclePlateNumber,
                      //       vehicleName: vehicleName,
                      //       seats: seats,
                      //       rentalPrice: rentalPrice,
                      //     )));
                },
                child: Text(
                  'Book Now',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            )));
  }
}
// =======
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:need_moto/screens/Request_Pending.dart';
// import 'package:need_moto/widget/car.dart';
//
// class Request extends StatelessWidget {
//   final String imgUrl;
//   final String vehicleName;
//   final String seats;
//   final String average;
//   final String kpml;
//   final String type;
//   final String ownerName;
//   final String ownerPhoneNumber;
//
//   String vehicleLocation;
//   String source;
//   String destination;
//   String pickupDateTime;
//   String returnDateTime;
//   String delivery;
//   String purpose;
//
//   Request(
//       {required this.imgUrl,
//       required this.vehicleName,
//       required this.seats,
//       required this.average,
//       required this.kpml,
//       required this.type,
//       required this.ownerName,
//       required this.ownerPhoneNumber,
//       required this.delivery,
//       required this.purpose,
//       required this.returnDateTime,
//       required this.pickupDateTime,
//       required this.source,
//       required this.destination,
//       required this.vehicleLocation});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Car(imgUrl: imgUrl, vehicleName: vehicleName),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     'Specifications',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 15,
//                       ),
//                       Container(
//                           alignment: Alignment.center,
//                           width: 100,
//                           height: 100,
//                           margin: EdgeInsets.all(5),
//                           padding: EdgeInsets.all(15),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Colors.black,
//                           ),
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 seats,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 'Seats',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           )),
//                       Container(
//                           alignment: Alignment.center,
//                           width: 100,
//                           height: 100,
//                           margin: EdgeInsets.all(5),
//                           padding: EdgeInsets.all(15),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Colors.black,
//                           ),
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 average,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 'Km/h',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           )),
//                       Container(
//                           alignment: Alignment.center,
//                           width: 100,
//                           height: 100,
//                           margin: EdgeInsets.all(5),
//                           padding: EdgeInsets.all(15),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Colors.black,
//                           ),
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 kpml,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 'KMPL',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           )),
//                       Container(
//                           alignment: Alignment.center,
//                           width: 100,
//                           height: 100,
//                           margin: EdgeInsets.all(5),
//                           padding: EdgeInsets.all(15),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Colors.black,
//                           ),
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Text(
//                                 type,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           )),
//                       SizedBox(
//                         width: 15,
//                       ),
//                     ],
//                   )),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     'Owner Details',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 20,
//                   ),
//                   CircleAvatar(
//                     radius: 25,
//                     child: Icon(Icons.person),
//                   ),
//                   SizedBox(
//                     width: 25,
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                           width: 150,
//                           height: 20,
//                           child: Text(
//                             ownerName,
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.w600),
//                           )),
//                       Container(
//                           width: 150,
//                           height: 15,
//                           child: Text(
//                             ownerPhoneNumber,
//                             style: TextStyle(fontSize: 14, color: Colors.grey),
//                           ))
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Padding(
//             padding: EdgeInsets.all(1),
//             child: SizedBox(
//               width: 250,
//               height: 50,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
//                 onPressed: () {
//                   // BookingColntroller.instance.booking(
//                   //   source,
//                   //   destination,
//                   //   pickupDateTime,
//                   //   returnDateTime,
//                   //   delivery,
//                   //   purpose,
//                   // );
//
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => RequestPending()));
//                 },
//                 child: Text(
//                   'Book Now',
//                   style: TextStyle(color: Colors.white, fontSize: 30),
//                 ),
//               ),
//             )));
//   }
// }
// >>>>>>> origin/main
