import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/screens/drawer_Screen/car_details.dart';

class RushWheel extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> vehicleDoc;

  const RushWheel(this.vehicleDoc, {super.key});

  @override
  State<RushWheel> createState() => _RushWheelState();
}

class _RushWheelState extends State<RushWheel> {
  bool forAndroid = false;
  bool _offRide = false;
  final Rxn<bool> selected = Rxn<bool>();

  late String vehicleName;
  late String vehicleNumber;
  late String kmReading;

  @override
  void initState() {
    super.initState();
    final vehicleData = widget.vehicleDoc.data();
    vehicleName = vehicleData?['vehicleName'] ?? '';
    vehicleNumber = vehicleData?['vehicleNumber'] ?? '';
    kmReading = vehicleData?['vehicleCurrentReading'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.24,
      // height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 10,
                spreadRadius: 1)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Name:",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                              Text(
                                vehicleName,
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                "Number:",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                              Text(
                                vehicleNumber,
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                "KM:",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                              Text(
                                kmReading,
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
                Column(
                  children: [
                    Switch(
                      activeColor: const Color.fromARGB(198, 244, 67, 54),
                      activeTrackColor:
                          const Color.fromARGB(126, 247, 151, 146),
                      inactiveThumbColor:
                          const Color.fromARGB(179, 211, 211, 211),
                      inactiveTrackColor:
                          const Color.fromARGB(255, 189, 188, 188),
                      splashRadius: 50.0,
                      value: forAndroid,
                      onChanged: (value) {
                        setState(() {
                          forAndroid = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    const CircleAvatar(
                      radius: 32,
                      backgroundColor:
                          Colors.green, //change color according to the status
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://imgd-ct.aeplcdn.com/370x208/n/cw/ec/128413/scorpio-exterior-right-front-three-quarter-46.jpeg?isig=0&q=75"),
                          radius: 27,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // SizedBox(height: 10,)
          const Divider(
            color: Colors.black,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        activeColor: const Color.fromARGB(255, 33, 103, 243),
                        value: selected.value == true,
                        onChanged: (val) {
                          if (val == true) {
                            selected.value = true;
                            setState(() {
                              _offRide = true;
                            });
                          } else {
                            selected.value = false;
                            setState(() {
                              _offRide = false;
                            });
                          }
                        },
                      ),
                    ),
                    _offRide
                        ? const Text(
                            "On Ride",
                            style: TextStyle(color: Colors.blue),
                          )
                        : const Text(
                            "Off Ride",
                            style: TextStyle(color: Colors.grey),
                          ),
                  ],
                ),
                _offRide
                    ? Row(children: [
                        InkWell(
                          onTap: () {
                            // Get.to(TrackVehicle());
                          },
                          child: const Text("Track Vehicle",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 10)),
                        ),
                      ])
                    : Container(),
                InkWell(
                  onTap: () {
                    Get.to(CarDetails(
                      vehicleName: vehicleName,
                      vehicleNumber: vehicleNumber,
                    ));
                  },
                  child: const Text("View more details",
                      style: TextStyle(color: Colors.red, fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
