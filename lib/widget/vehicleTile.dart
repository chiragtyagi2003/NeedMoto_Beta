
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/main.dart';
import 'package:need_moto/widget/request.dart';
import 'package:need_moto/screens/userkyc.dart';

import '../controllers/main_controller.dart';

class VehicleTile extends StatefulWidget {
  final String imgUrl;
  final String vehicleName;
  final String seats;
  final String rentalPricePerKm;
  final String perKm;
  final String distanceFromYou;
  final String kpml;
  final String type;
  final String ownerName;
  final String ownerPhoneNumber;
  final String average;
  final String vehicleNumber;
  final String base_12;
  final String base_24;
  final String pricePerKmCust;
  final String pricerPerHourCust;

  // final String userId;

  RxString userseats;
  String vehicleLocation;
  String source;
  String destination;
  String pickupDateTime;
  String returnDateTime;
  String delivery;
  String purpose;

  VehicleTile({
    required this.imgUrl,
    required this.vehicleName,
    required this.seats,
    required this.rentalPricePerKm,
    required this.perKm,
    required this.distanceFromYou,
    required this.kpml,
    required this.type,
    required this.ownerName,
    required this.ownerPhoneNumber,
    required this.average,
    required this.userseats,
    required this.vehicleLocation,
    required this.source,
    required this.destination,
    required this.pickupDateTime,
    required this.returnDateTime,
    required this.delivery,
    required this.purpose,
    required this.vehicleNumber,
    required this.pricePerKmCust,
    required this.pricerPerHourCust,
    required this.base_12,
    required this.base_24,
    // required this.userId
  });

  @override
  State<VehicleTile> createState() => _VehicleTileState();
}

class _VehicleTileState extends State<VehicleTile> {

  MainController mainController = Get.find();
  bool kycdone = false;
  double rentalPrice = 0.0;
  String distance = "150";
  bool hasCompletedKYC = false; // Track whether the action is completed

  // getKycStatus() async {
  //   await CheckKyc.checkKycdone(widget.userId).then((iskycdone) {
  //     setState(() {
  //       // isLoading = false;
  //       kycdone = iskycdone;
  //     });
  //   });
  // }

  // void calculateRentalPrice() {
  //
  //   double basePrice;
  //   double distanceLimit;
  //   double pricePerKmCust = double.parse(mainController.pricePerKmCust.text);
  //   double pricePerHourCust = double.parse(mainController.pricePerHourCust.text);
  //   double? numberOfExtraHours = double.tryParse(mainController.extraHoursController.text);
  //   if (numberOfExtraHours == null) {
  //     print('Invalid value for numberOfExtraHours');
  //     return;
  //   }
  //
  //   double? distance = double.tryParse(mainController.distanceController.text);
  //   if (distance == null) {
  //     print('Invalid value for distance');
  //     return;
  //   }
  //
  //   double? userChoiceHours = double.tryParse(mainController.userChoiceHoursController.text);
  //   if (userChoiceHours == null) {
  //     print('Invalid value for userChoiceHours');
  //     return;
  //   }
  //
  //   // Set base price and distance limit based on conditions
  //   if (userChoiceHours == 12) {
  //     basePrice = double.parse(mainController.base12PriceController.text);
  //   } else {
  //     basePrice = double.parse(mainController.base24PriceController.text);
  //   }
  //
  //   if (userChoiceHours == 12) {
  //     distanceLimit = 150.0;
  //   } else {
  //     distanceLimit = 350.0;
  //   }
  //
  //   double extraHoursCost = numberOfExtraHours * pricePerHourCust;
  //   double distanceCost = (distance - distanceLimit) * pricePerKmCust;
  //
  //   double totalCost = basePrice + extraHoursCost + distanceCost;
  //   print(totalCost);
  //   mainController.totalPriceController.text  = totalCost.toString();
  //   print(mainController.totalPriceController.text);
  // }


  Future<void> checkActionCompletion() async {
    print('called');
    // Get the current user
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve the user document from Firestore
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('customers').doc(user.uid).get();
      final bool fieldStatus = snapshot.data()?['kyc_status'] ?? false;

      if (fieldStatus == false) {
        // If the field is false, navigate to the action completion page
        showCupertinoAlertDialog(context);
      } else {
        // If the field is true, set the flag and continue to the main app
        setState(() {
          hasCompletedKYC = true;
        });
        // Handle booking logic here
        Get.to(Request(
          vehicleLocation: widget.vehicleLocation,
          source: widget.source,
          destination: widget.destination,
          delivery: widget.delivery,
          pickupDateTime: widget.pickupDateTime,
          returnDateTime: widget.returnDateTime,
          purpose: widget.purpose,
          imgUrl: widget.imgUrl,
          vehicleName: widget.vehicleName,
          seats: widget.seats,
          average: widget.average,
          kpml: widget.kpml,
          type: widget.type,
          ownerName: widget.ownerName,
          ownerPhoneNumber: widget.ownerPhoneNumber,
          vehiclePlateNumber: widget.vehicleNumber,
          base_12: widget.base_12,
          base_24: widget.base_24,
          pricePerKmCust: widget.pricePerKmCust,
          pricerPerHourCust: widget.pricerPerHourCust,
          rentalPrice: rentalPrice,
        ));
      }
    }
  }

  double calculateRentalPrice() {
    // Retrieve the necessary values from the mainController or any other relevant source
    double pricePerKmCust = double.parse(widget.pricePerKmCust);
    double numberOfExtraHours = double.parse(mainController.extraHoursController.text);
    double distance = double.parse(mainController.distanceController.text);
    double userChoiceHours = double.parse(mainController.userChoiceHoursController.text);
    double basePrice = userChoiceHours == 12 ? double.parse(widget.base_12) : double.parse(widget.base_24);
    double distanceLimit = userChoiceHours == 12 ? 150.0 : 350.0;

    // Perform the calculations
    double extraHoursCost = numberOfExtraHours * double.parse(widget.pricerPerHourCust);
    print(extraHoursCost);
    double distanceCost = (distance - distanceLimit) * pricePerKmCust;
    double totalCost = basePrice + extraHoursCost + distanceCost;

    setState(() {
      rentalPrice = totalCost;
    });

    return rentalPrice;
  }

  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // Add listeners to relevant controllers for parameter changes
  //   mainController.pricePerKmCust.addListener(calculateRentalPrice);
  //   mainController.extraHoursController.addListener(calculateRentalPrice);
  //   mainController.distanceController.addListener(calculateRentalPrice);
  //   mainController.userChoiceHoursController.addListener(calculateRentalPrice);
  //   setState(() {
  //     // Update rental price whenever distance changes
  //     calculateRentalPrice();
  //   });
  //   //
  //   // // // Calculate initial rental price
  //   calculateRentalPrice();
  // }
  //
  // @override
  // void dispose() {
  //   // Remove listeners to prevent memory leaks
  //   mainController.pricePerKmCust.removeListener(calculateRentalPrice);
  //   mainController.extraHoursController.removeListener(calculateRentalPrice);
  //   mainController.distanceController.removeListener(calculateRentalPrice);
  //   mainController.userChoiceHoursController.removeListener(calculateRentalPrice);
  //
  //   super.dispose();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainController.distanceController.addListener(() {
      setState(() {
        distance = mainController.distanceController.text;
        rentalPrice = calculateRentalPrice();
      });
    });

    mainController.extraHoursController.addListener(() {
      setState(() {
        rentalPrice = calculateRentalPrice();
      });
    });

    mainController.userChoiceHoursController.addListener(() {
      setState(() {
        rentalPrice  = calculateRentalPrice();
      });
    });

    calculateRentalPrice();

  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Vehicle Details
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vehicle Name
                  Text(
                    widget.vehicleName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),

                  SizedBox(height: 8.0),

                  // Seats

                  Row(
                    children: [
                      Text(
                        '${widget.seats}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Icon(Icons.event_seat_sharp),
                    ],
                  ),

                  SizedBox(height: 8.0),

                  // Rental Price Per Km and Per Km
                  Text(
                    'Rs ${rentalPrice.toStringAsFixed(2)}/- Per day ${distance} km',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),

                  SizedBox(height: 8.0),

                  // Distance From You
                  Text(
                    '${widget.distanceFromYou} km away from you',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),

                  SizedBox(height: 16.0),

                  // Book Now Button
                  ElevatedButton(
                    onPressed: () {
                      checkActionCompletion();
                    },
                    child: Text('Book Now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Vehicle Image
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(widget.imgUrl),
            ),
          ),
        ],
      ),
    );
  }

  showCupertinoAlertDialog(BuildContext context) {
    showDialog(
        builder: (context) => CupertinoAlertDialog(
              title: Column(
                children: <Widget>[
                  Text(
                    "Complete your KYC",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              content: Text(
                "Please complete your KYC\n to book vehicle",
                style: TextStyle(fontSize: 16),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => userKYC(
                                  seats: widget.userseats,
                                  vehicleLocation: widget.vehicleLocation,
                                  source: widget.source,
                                  destination: widget.destination,
                                  pickupDateTime: widget.pickupDateTime,
                                  returnDateTime: widget.returnDateTime,
                                  delivery: widget.delivery,
                                  purpose: widget.purpose,
                                )));
                  },
                ),
                CupertinoDialogAction(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
        context: context);
  }
}
// =======
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:need_moto/widget/Request2.dart';
// import 'package:need_moto/widget/request.dart';
// import 'package:need_moto/screens/tenth.dart';
//
// class VehicleTile extends StatefulWidget {
//   final String imgUrl;
//   final String vehicleName;
//   final String seats;
//   final String rentalPricePerKm;
//   final String perKm;
//   final String distanceFromYou;
//   final String kpml;
//   final String type;
//   final String ownerName;
//   final String ownerPhoneNumber;
//   final String average;
//   // final String userId;
//
//   RxString userseats;
//   String vehicleLocation;
//   String source;
//   String destination;
//   String pickupDateTime;
//   String returnDateTime;
//   String delivery;
//   String purpose;
//
//   VehicleTile({
//     required this.imgUrl,
//     required this.vehicleName,
//     required this.seats,
//     required this.rentalPricePerKm,
//     required this.perKm,
//     required this.distanceFromYou,
//     required this.kpml,
//     required this.type,
//     required this.ownerName,
//     required this.ownerPhoneNumber,
//     required this.average,
//     required this.userseats,
//     required this.vehicleLocation,
//     required this.source,
//     required this.destination,
//     required this.pickupDateTime,
//     required this.returnDateTime,
//     required this.delivery,
//     required this.purpose,
//     // required this.userId
//   });
//
//   @override
//   State<VehicleTile> createState() => _VehicleTileState();
// }
//
// class _VehicleTileState extends State<VehicleTile> {
//   bool kycdone = false;
//   // getKycStatus() async {
//   //   await CheckKyc.checkKycdone(widget.userId).then((iskycdone) {
//   //     setState(() {
//   //       // isLoading = false;
//   //       kycdone = iskycdone;
//   //     });
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: Colors.white),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           Card(
//             elevation: 0,
//             child: Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Vehicle Details
//                 Expanded(
//                   flex: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8.0, right: 8),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Vehicle Name
//
//                         Text(
//                           widget.vehicleName,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18.0,
//                           ),
//                         ),
//
//                         SizedBox(height: 8.0),
//
//                         // Seats
//
//                         Row(
//                           children: [
//                             Text(
//                               '${widget.seats}',
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                               ),
//                             ),
//                             Icon(Icons.event_seat_sharp),
//                           ],
//                         ),
//
//                         SizedBox(height: 8.0),
//
//                         // Rental Price Per Km and Per Km
//                         Text(
//                           'Rs ${widget.rentalPricePerKm}/- Per day ${widget.perKm} km',
//                           style: TextStyle(
//                             fontSize: 16.0,
//                           ),
//                         ),
//
//                         SizedBox(height: 8.0),
//
//                         // Distance From You
//                         Text(
//                           '${widget.distanceFromYou} km away from you',
//                           style: TextStyle(fontSize: 12.0, color: Colors.grey),
//                         ),
//
//                         SizedBox(height: 16.0),
//                         Container(
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black26,
//                                   offset: Offset(0, 4),
//                                   blurRadius: 5.0)
//                             ],
//                             gradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               stops: [0.0, 1.0],
//                               colors: [Color(0xFF20A4F3), Color(0xFF182B3A)],
//                             ),
//                             color: Colors.deepPurple.shade300,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                               shape: MaterialStateProperty.all<
//                                   RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20.0),
//                                 ),
//                               ),
//                               minimumSize:
//                                   MaterialStateProperty.all(Size(10, 10)),
//                               backgroundColor:
//                                   MaterialStateProperty.all(Colors.transparent),
//                               // elevation: MaterialStateProperty.all(3),
//                               shadowColor:
//                                   MaterialStateProperty.all(Colors.transparent),
//                             ),
//                             onPressed: () {
//                               // Handle booking logic here
//                               // showCupertinoAlertDialog(context);
//                               Get.to(
//                                 DetailsPage(
//                                     milage: widget.kpml,
//                                     type: widget.type,
//                                     speed: widget.average,
//                                     bags: '5',
//                                     carImage: 'assets/i30n.png',
//                                     carName: widget.vehicleName,
//                                     carPrice: widget.rentalPricePerKm,
//                                     carRating: '4.5',
//                                     isRotated: true,
//                                     people: widget.seats,
//                                     ownername: widget.ownerName,
//                                     phonenumber: widget.ownerPhoneNumber),
//                               );
//                               // Get.to(Request(
//                               //     vehicleLocation: widget.vehicleLocation,
//                               //     source: widget.source,
//                               //     destination: widget.destination,
//                               //     delivery: widget.delivery,
//                               //     pickupDateTime: widget.pickupDateTime,
//                               //     returnDateTime: widget.returnDateTime,
//                               //     purpose: widget.purpose,
//                               //     imgUrl: widget.imgUrl,
//                               //     vehicleName: widget.vehicleName,
//                               //     seats: widget.seats,
//                               //     average: widget.average,
//                               //     kpml: widget.kpml,
//                               //     type: widget.type,
//                               //     ownerName: widget.ownerName,
//                               //     ownerPhoneNumber: widget.ownerPhoneNumber));
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 5, right: 5),
//                               child: Text(
//                                 'Book Now',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   // fontWeight: FontWeight.w700,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         // // Book Now Button
//                         // ElevatedButton(
//                         //   onPressed: () {
//                         //     // Handle booking logic here
//                         //     // showCupertinoAlertDialog(context);
//                         //     Get.to(
//                         //       DetailsPage(
//                         //           milage: widget.kpml,
//                         //           type: widget.type,
//                         //           speed: widget.average,
//                         //           bags: '5',
//                         //           carImage: 'assets/i30n.png',
//                         //           carName: widget.vehicleName,
//                         //           carPrice: widget.rentalPricePerKm,
//                         //           carRating: '4.5',
//                         //           isRotated: true,
//                         //           people: widget.seats,
//                         //           ownername: widget.ownerName,
//                         //           phonenumber: widget.ownerPhoneNumber),
//                         //     );
//                         //     // Get.to(Request(
//                         //     //     vehicleLocation: widget.vehicleLocation,
//                         //     //     source: widget.source,
//                         //     //     destination: widget.destination,
//                         //     //     delivery: widget.delivery,
//                         //     //     pickupDateTime: widget.pickupDateTime,
//                         //     //     returnDateTime: widget.returnDateTime,
//                         //     //     purpose: widget.purpose,
//                         //     //     imgUrl: widget.imgUrl,
//                         //     //     vehicleName: widget.vehicleName,
//                         //     //     seats: widget.seats,
//                         //     //     average: widget.average,
//                         //     //     kpml: widget.kpml,
//                         //     //     type: widget.type,
//                         //     //     ownerName: widget.ownerName,
//                         //     //     ownerPhoneNumber: widget.ownerPhoneNumber));
//                         //   },
//                         //   child: Text('Book Now'),
//                         //   style: ElevatedButton.styleFrom(
//                         //     backgroundColor: Colors.lightBlueAccent,
//                         //     shape: RoundedRectangleBorder(
//                         //       borderRadius: BorderRadius.circular(20.0),
//                         //     ),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Vehicle Image
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Hero(
//                         tag: widget.vehicleName,
//                         child: Image.asset('assets/i30n.png')),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Divider(
//             color: Colors.black,
//             thickness: 0.2,
//           )
//         ],
//       ),
//     );
//   }
//
// //   showCupertinoAlertDialog(BuildContext context) {
// //     showDialog(
// //         builder: (context) => CupertinoAlertDialog(
// //               title: Column(
// //                 children: <Widget>[
// //                   Text(
// //                     "Complete your KYC",
// //                     style: TextStyle(fontSize: 20),
// //                   ),
// //                 ],
// //               ),
// //               content: Text(
// //                 "Please complete your KYC\n to book vehicle",
// //                 style: TextStyle(fontSize: 16),
// //               ),
// //               actions: <Widget>[
// //                 CupertinoDialogAction(
// //                   child: Text("Yes"),
// //                   onPressed: () {
// //                     Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                             builder: (context) => Tenth(
// //                                   seats: widget.userseats,
// //                                   vehicleLocation: widget.vehicleLocation,
// //                                   source: widget.source,
// //                                   destination: widget.destination,
// //                                   pickupDateTime: widget.pickupDateTime,
// //                                   returnDateTime: widget.returnDateTime,
// //                                   delivery: widget.delivery,
// //                                   purpose: widget.purpose,
// //                                 )));
// //                   },
// //                 ),
// //                 CupertinoDialogAction(
// //                   child: Text("No"),
// //                   onPressed: () {
// //                     Navigator.of(context).pop();
// //                   },
// //                 ),
// //               ],
// //             ),
// //         context: context);
// //   }
// // }
// }
// >>>>>>> origin/main
