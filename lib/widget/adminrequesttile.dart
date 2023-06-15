import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/widget/Details_Admin.dart';
import 'package:need_moto/widget/Request2.dart';
import 'package:need_moto/widget/request.dart';
import 'package:need_moto/screens/tenth.dart';

class VehicleTile1 extends StatefulWidget {
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
  // final String userId;

  RxString userseats;
  String vehicleLocation;
  String source;
  String destination;
  String pickupDateTime;
  String returnDateTime;
  String delivery;
  String purpose;

  bool booked;

  VehicleTile1({
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
    required this.booked,
    // required this.userId
  });

  @override
  State<VehicleTile1> createState() => _VehicleTile1State();
}

class _VehicleTile1State extends State<VehicleTile1> {
  bool kycdone = false;
  // getKycStatus() async {
  //   await CheckKyc.checkKycdone(widget.userId).then((iskycdone) {
  //     setState(() {
  //       // isLoading = false;
  //       kycdone = iskycdone;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 1,
                child: Container(
                  height: 250,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Vehicle Name

                                Text(
                                  widget.vehicleName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 23.0,
                                  ),
                                ),

                                SizedBox(height: 8.0),

                                // Seats

                                Row(
                                  children: [
                                    Text(
                                      'Seats :',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      '${widget.seats}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    // Icon(Icons.event_seat_sharp),
                                  ],
                                ),

                                // Rental Price Per Km and Per Km

                                Row(
                                  children: [
                                    Text(
                                      'Rent Amount : ',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      '₹${widget.rentalPricePerKm}/-',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Text(
                                      'Daily Limit :',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      '  ${widget.perKm} km',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16.0),

                                SizedBox(
                                  height: 15,
                                )

                                // // Book Now Button
                                // ElevatedButton(
                                //   onPressed: () {
                                //     // Handle booking logic here
                                //     // showCupertinoAlertDialog(context);
                                //     Get.to(
                                //       DetailsPage(
                                //           milage: widget.kpml,
                                //           type: widget.type,
                                //           speed: widget.average,
                                //           bags: '5',
                                //           carImage: 'assets/i30n.png',
                                //           carName: widget.vehicleName,
                                //           carPrice: widget.rentalPricePerKm,
                                //           carRating: '4.5',
                                //           isRotated: true,
                                //           people: widget.seats,
                                //           ownername: widget.ownerName,
                                //           phonenumber: widget.ownerPhoneNumber),
                                //     );
                                //     // Get.to(Request(
                                //     //     vehicleLocation: widget.vehicleLocation,
                                //     //     source: widget.source,
                                //     //     destination: widget.destination,
                                //     //     delivery: widget.delivery,
                                //     //     pickupDateTime: widget.pickupDateTime,
                                //     //     returnDateTime: widget.returnDateTime,
                                //     //     purpose: widget.purpose,
                                //     //     imgUrl: widget.imgUrl,
                                //     //     vehicleName: widget.vehicleName,
                                //     //     seats: widget.seats,
                                //     //     average: widget.average,
                                //     //     kpml: widget.kpml,
                                //     //     type: widget.type,
                                //     //     ownerName: widget.ownerName,
                                //     //     ownerPhoneNumber: widget.ownerPhoneNumber));
                                //   },
                                //   child: Text('Book Now'),
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor: Colors.lightBlueAccent,
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(20.0),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),

                        // Vehicle Image
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Hero(
                                tag: widget.vehicleName,
                                child: Image.asset(
                                  'assets/i30n.png',
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 30.0,
            right: 15.0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.booked ? Colors.red : Colors.green),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18, top: 8, bottom: 8),
                child: Text(
                  widget.booked ? 'Booked' : 'Available',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 15,
              right: MediaQuery.of(context).size.width / 3.25,
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 158, 175, 76)),
                    onPressed: () {
                      Get.to(
                        DetailsAdmin(
                            milage: widget.kpml,
                            type: widget.type,
                            speed: widget.average,
                            bags: '5',
                            carImage: 'assets/i30n.png',
                            carName: widget.vehicleName,
                            carPrice: widget.rentalPricePerKm,
                            carRating: '4.5',
                            isRotated: true,
                            people: widget.seats,
                            ownername: widget.ownerName,
                            phonenumber: widget.ownerPhoneNumber),
                      );
                    },
                    child: Text('More Details'),
                  )))
        ]),
      ),
    );
  }
}
