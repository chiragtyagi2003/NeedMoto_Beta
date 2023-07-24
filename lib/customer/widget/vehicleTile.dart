import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/screens/userkyc.dart';
import 'package:need_moto/customer/widget/Request.dart';

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

  final RxString userseats;
  final String vehicleLocation;
  final String source;
  final String destination;
  final String pickupDateTime;
  final String returnDateTime;
  final String delivery;
  final String purpose;

  const VehicleTile({
    super.key,
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
  bool hasCompletedKYC = false;
  late String dailyLimitAsString = widget.perKm;

  // Create a function to update the sum
  void updateSum() {
    // Convert the strings to integers using int.parse()
    double perKm = double.parse(widget.perKm);
    double distance = double.parse(mainController.distanceController.text);

    // Add the two integers
    double sum = perKm + distance;

    print(sum);

    // Convert the sum back to a string using toString()
    // Force the UI to update with the new value
    setState(() {
      dailyLimitAsString = sum.toString();
    });

    print('daily $dailyLimitAsString');
  }


  Future<void> checkActionCompletion() async {
    try {
      // Get the current user
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Retrieve the user document from Firestore
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('customers')
                .doc(user.uid)
                .get();
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
            vehicleLocation: mainController
                .vehicleNeedLocations.text, //widget.vehicleLocation,
            source: mainController.vehicleSource.text, //widget.source,
            destination:
                mainController.vehicleDestination.text, //widget.destination,
            delivery: mainController.delivery.text, //widget.delivery,
            pickupDateTime:
                mainController.pickupDateTime.text, //widget.pickupDateTime,
            returnDateTime:
                mainController.returnDateTime.text, //widget.returnDateTime,
            purpose: mainController.purpose.text, //widget.purpose,
            imgUrl: 'assets/i30n.png',
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
            isRotated: true,
            vehicleRating: '4.5',
            bags: '5',
          ));
        }
      }
    } catch (e) {
      // Handle any errors that occur during check action completion
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

  double calculateRentalPrice() {
    // Retrieve the necessary values from the mainController or any other relevant source
    double pricePerKmCust = double.parse(widget.pricePerKmCust);
    double distance = double.parse(mainController.distanceController.text);
    double userChoiceHours =
        double.parse(mainController.userChoiceHoursController.text);
    double distanceLimit = userChoiceHours == 12 ? 150.0 : 350.0;

    double totalHoursDuration = 0.0;
    totalHoursDuration = double.parse(mainController.calculateDuration(
        mainController.pickupDateTime.text,
        mainController.returnDateTime.text));

    double distanceCost = distance > distanceLimit
        ? (distance - distanceLimit) * pricePerKmCust
        : 0.0;

    double totalCost = double.parse(widget.base_12);
    if (totalHoursDuration > 23) {
      totalCost += double.parse(widget.base_24);
    }

    totalCost += distanceCost;

    setState(() {
      rentalPrice = totalCost;
    });

    return rentalPrice;
  }

  //
  // @o

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainController.distanceController.addListener(() {

      setState(() {
        distance = mainController.distanceController.text;
        rentalPrice = calculateRentalPrice();
      });

      updateSum();
    });

    mainController.extraHoursController.addListener(() {
      setState(() {
        rentalPrice = calculateRentalPrice();
      });
    });

    mainController.userChoiceHoursController.addListener(() {
      setState(() {
        rentalPrice = calculateRentalPrice();
      });
    });

    calculateRentalPrice();

  }

  // Don't forget to remove the listener when the widget is disposed to avoid memory leaks
  @override
  void dispose() {
    mainController.distanceController.removeListener(updateSum);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 1,
                child: Container(
                  height: 210,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Vehicle Details
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Vehicle Name

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.vehicleName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 23.0,
                                      ),
                                    ),
                                    Text(
                                      '(${widget.distanceFromYou} km away from you)',
                                      style: const TextStyle(
                                          fontSize: 12.0, color: Colors.grey),
                                    ),
                                  ],
                                ),

                                // Seats

                                Row(
                                  children: [
                                    const Text(
                                      'Seats :',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      widget.seats,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    // Icon(Icons.event_seat_sharp),
                                  ],
                                ),

                                // Rental Price Per Km and Per Km

                                Row(
                                  children: [
                                    const Text(
                                      'Rent Amount : ',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      '₹$rentalPrice/-',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    const Text(
                                      'Daily Limit :',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      '  $dailyLimitAsString km',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),

                                // Book Now Button
                              ],
                            ),
                          ),
                        ),

                        // Vehicle Image
                        Expanded(
                          child: Hero(
                              tag: widget.rentalPricePerKm,
                              child: Image.asset(
                                'assets/i30n.png',
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 15.0,
          child: ElevatedButton(
            onPressed: () {
              checkActionCompletion();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: const Text('Book Now'),
          ),
        ),
      ]),
    );
  }

  showCupertinoAlertDialog(BuildContext context) {
    showDialog(
        builder: (context) => CupertinoAlertDialog(
              title: const Column(
                children: <Widget>[
                  Text(
                    "Complete your KYC",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              content: const Text(
                "Please complete your KYC\n to book vehicle",
                style: TextStyle(fontSize: 16),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text("Yes"),
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
                  child: const Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
        context: context);
  }
}
