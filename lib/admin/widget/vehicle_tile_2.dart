import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/admin/widget/details_admin.dart';

class VehicleTile2 extends StatefulWidget {
  final String imgUrl;
  final String vehicleName;
  final String seats;
  final String rentalPricePerDay;
  final String perKm;
  final String distanceFromYou;
  final String kmpl;
  final String type;
  final String ownerName;
  final String ownerPhoneNumber;
  final String average;
  final String vehicleNumber;
  bool booked;

  VehicleTile2({super.key,
    required this.imgUrl,
    required this.vehicleName,
    required this.seats,
    required this.rentalPricePerDay,
    required this.perKm,
    required this.distanceFromYou,
    required this.kmpl,
    required this.type,
    required this.ownerName,
    required this.ownerPhoneNumber,
    required this.average,
    required this.booked,
    required this.vehicleNumber,
    // required this.userId
  });

  @override
  State<VehicleTile2> createState() => _VehicleTile2State();
}

class _VehicleTile2State extends State<VehicleTile2> {
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

                                Text(
                                  widget.vehicleNumber,
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
                                      'Price/Day: ',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      '₹${widget.rentalPricePerDay}/-',
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
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Vehicle Image
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Hero(
                                tag: widget.rentalPricePerDay,
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
                        backgroundColor: const Color.fromARGB(255, 158, 175, 76)),
                    onPressed: () {
                      Get.to(
                        DetailsAdmin(
                            mileage: widget.kmpl,
                            type: widget.type,
                            speed: widget.average,
                            bags: '5',
                            carImage: 'assets/i30n.png',
                            carName: widget.vehicleName,
                            carPrice: widget.rentalPricePerDay,
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
