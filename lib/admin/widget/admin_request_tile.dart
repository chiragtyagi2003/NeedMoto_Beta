import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/admin/widget/details_admin.dart';

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
    required this.booked,
    // required this.userId
  });

  @override
  State<VehicleTile1> createState() => _VehicleTile1State();
}

class _VehicleTile1State extends State<VehicleTile1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: [
          Column(
            children: [
              const SizedBox(
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
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 23.0,
                                  ),
                                ),

                                const SizedBox(height: 8.0),

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
                                      '₹${widget.rentalPricePerKm}/-',
                                      style: const TextStyle(
                                        fontSize: 16.0,
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
                                      '  ${widget.perKm} km',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16.0),

                                const SizedBox(
                                  height: 15,
                                )
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
                  style: const TextStyle(
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
                        backgroundColor:
                            const Color.fromARGB(255, 158, 175, 76)),
                    onPressed: () {
                      Get.to(
                        DetailsAdmin(
                            mileage: widget.kpml,
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
                    child: const Text('More Details'),
                  )))
        ]),
      ),
    );
  }
}
