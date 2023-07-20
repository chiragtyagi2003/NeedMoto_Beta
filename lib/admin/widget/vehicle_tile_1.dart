import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/admin/screens/add_vehicle.dart';

class VehicleTile1 extends StatefulWidget {
  DocumentSnapshot<Map<String, dynamic>> vehicleSnapshot;

  VehicleTile1({super.key,
    required this.vehicleSnapshot,
  });

  @override
  State<VehicleTile1> createState() => _VehicleTile1State();
}

class _VehicleTile1State extends State<VehicleTile1> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> vehicleData = widget.vehicleSnapshot.data()!;
    final vehicleId = widget.vehicleSnapshot.id;
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
                                  "${vehicleData['vehicleName']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 23.0,
                                  ),
                                ),

                                const SizedBox(height: 8.0),

                                Row(
                                  children: [
                                    const Text(
                                      'Owner Name :',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      '${vehicleData['ownerName']}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    // Icon(Icons.event_seat_sharp),
                                  ],
                                ),

                                const SizedBox(
                                  height: 8.0,
                                ),

                                Row(
                                  children: [
                                    const Text(
                                      'Vehicle Number:',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      '${vehicleData['vehicleNumber']}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    // Icon(Icons.event_seat_sharp),
                                  ],
                                ),

                                const SizedBox(
                                  height: 8.0,
                                ),
                                // Seats

                                // Row(
                                //   children: [
                                //     Text(
                                //       'Seats :',
                                //       style: TextStyle(
                                //         fontSize: 16.0,
                                //       ),
                                //     ),
                                //     Text(
                                //       "",
                                //       // '${vehicleData['seating']}',
                                //       style: TextStyle(
                                //         fontSize: 16.0,
                                //       ),
                                //     ),
                                //     // Icon(Icons.event_seat_sharp),
                                //   ],
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
                                tag: "",
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
          // Positioned(
          //   top: 30.0,
          //   right: 15.0,
          //   child: Container(
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         color: widget.booked ? Colors.red : Colors.green),
          //     child: Padding(
          //       padding: const EdgeInsets.only(
          //           left: 18.0, right: 18, top: 8, bottom: 8),
          //       child: Text(
          //         widget.booked ? 'Booked' : 'Available',
          //         style: TextStyle(
          //             color: Colors.white, fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ),
          // ),
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
                      Get.to(AddVehicle(
                        vehicleId: vehicleId,
                      ));
                      // Get.to(
                      //   DetailsAdmin(
                      //       milage: widget.kpml,
                      //       type: widget.type,
                      //       speed: widget.average,
                      //       bags: '5',
                      //       carImage: 'assets/i30n.png',
                      //       carName: widget.vehicleName,
                      //       carPrice: widget.rentalPricePerKm,
                      //       carRating: '4.5',
                      //       isRotated: true,
                      //       people: widget.seats,
                      //       ownername: widget.ownerName,
                      //       phonenumber: widget.ownerPhoneNumber),
                      // );
                    },
                    child: const Text('Add'),
                  )))
        ]),
      ),
    );
  }
}
