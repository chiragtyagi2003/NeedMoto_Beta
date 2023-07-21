import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/Request_Controller.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/screens/Home.dart';
import 'package:need_moto/customer/screens/pickup_vehicle.dart';
import 'package:need_moto/customer/screens/ready_to_pickup.dart';

class RequestAccepted extends StatefulWidget {
  final String source;
  final String destination;
  final String pickupDateTime;
  final String returnDateTime;
  final String delivery;
  final String purpose;
  final String ownerName;
  final String ownerPhoneNumber;
  final String type;
  final String vehicleNumber;
  final String vehicleName;
  final String seats;
  final String base_12;
  final String base_24;
  final double rentalPrice;

  const RequestAccepted(
      {super.key,
      required this.source,
      required this.destination,
      required this.pickupDateTime,
      required this.returnDateTime,
      required this.delivery,
      required this.purpose,
      required this.ownerName,
      required this.ownerPhoneNumber,
      required this.type,
      required this.vehicleNumber,
      required this.vehicleName,
      required this.seats,
      required this.rentalPrice,
      required this.base_12,
      required this.base_24});

  @override
  State<RequestAccepted> createState() => _RequestAcceptedState();
}

class _RequestAcceptedState extends State<RequestAccepted> {
  void _handleBackButton() {
    // Perform your desired navigation here
    Get.to(const Home());
  }

  RequestController requestController = Get.find();
  MainController mainController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Manually handle the back button press
        _handleBackButton();
        // Return false to prevent the default back button behavior
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.green.shade400,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        Get.offAll(const Home());
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Request has been sent to owner',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 140,
                    ),
                    SizedBox(
                      width: 75,
                      height: 75,
                      child: Image.asset(
                        'assets/images/tick.png',
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 32,
                    ),
                    Text(
                      'Your request have been approved from Owner.\n Check vehicle details and complete payment.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 900,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(15)),
                      Container(
                        padding: const EdgeInsets.all(15),
                        width: 380,
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade400),
                        child: Text(
                          '${widget.vehicleName} / ${widget.seats} Seater / ${widget.rentalPrice}/-',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.all(5)),
                          Column(
                            children: [
                              const Padding(padding: EdgeInsets.all(15)),
                              const SizedBox(
                                width: 150,
                                height: 15,
                                child: Text(
                                  'From',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              SizedBox(
                                  width: 150,
                                  height: 35,
                                  child: TextField(
                                      controller: TextEditingController(
                                          text: widget.source),
                                      enabled: false,
                                      decoration: const InputDecoration(
                                          hintText: 'hyderabad'))),
                            ],
                          ),
                          SizedBox(
                            width: 35,
                            height: 10,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.swap_horiz,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              const Padding(padding: EdgeInsets.all(15)),
                              const SizedBox(
                                width: 130,
                                height: 15,
                                child: Text(
                                  'To',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              SizedBox(
                                  width: 130,
                                  height: 35,
                                  child: TextField(
                                      controller: TextEditingController(
                                          text: widget.destination),
                                      enabled: false,
                                      decoration: const InputDecoration(
                                          hintText: 'Chittoor'))),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.all(5)),
                          Column(
                            children: [
                              const Padding(padding: EdgeInsets.all(15)),
                              const SizedBox(
                                width: 150,
                                height: 15,
                                child: Text(
                                  'Pickup date and time ',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                height: 35,
                                child: TextField(
                                    controller: TextEditingController(
                                        text: widget.pickupDateTime),
                                    enabled: false,
                                    decoration: const InputDecoration(
                                      hintText: '22-04-23',
                                      hintStyle: TextStyle(fontSize: 14),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 35,
                            height: 10,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              const Padding(padding: EdgeInsets.all(15)),
                              const SizedBox(
                                width: 140,
                                height: 15,
                                child: Text(
                                  'Drop date and time',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              SizedBox(
                                  width: 140,
                                  height: 35,
                                  child: TextField(
                                    controller: TextEditingController(
                                        text: widget.returnDateTime),
                                    enabled: false,
                                    decoration: const InputDecoration(
                                      hintText: '24-02-23',
                                      hintStyle: TextStyle(fontSize: 14),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.all(5)),
                          Column(
                            children: [
                              const Padding(padding: EdgeInsets.all(15)),
                              const SizedBox(
                                width: 150,
                                height: 15,
                                child: Text(
                                  'Home delivery or pickup',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              SizedBox(
                                  width: 150,
                                  height: 35,
                                  child: TextField(
                                      controller: TextEditingController(
                                          text: widget.delivery),
                                      enabled: false,
                                      decoration: const InputDecoration(
                                          hintText: 'Pickup'))),
                            ],
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                          Column(
                            children: [
                              const Padding(padding: EdgeInsets.all(15)),
                              const SizedBox(
                                width: 140,
                                height: 15,
                                child: Text(
                                  'Purpose',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              SizedBox(
                                  width: 140,
                                  height: 35,
                                  child: TextField(
                                      controller: TextEditingController(
                                          text: widget.purpose),
                                      enabled: false,
                                      decoration: const InputDecoration(
                                          hintText: 'Function'))),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Card(
                        elevation: 10,
                        child: SizedBox(
                          width: 325,
                          height: 300,
                          child: Column(
                            children: [
                              const Padding(padding: EdgeInsets.all(25)),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 130,
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child:
                                        Image.asset('assets/images/wheel.png'),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 113,
                                  ),
                                  SizedBox(
                                      width: 150,
                                      height: 50,
                                      child: Text(
                                          '${mainController.assignedOwnerNameController.text}\n+91 ${mainController.assignedOwnerPhoneNumberController.text}'))
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text('Fuel type'),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  Text(mainController.typeController.text)
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text('Vehicle number'),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(mainController
                                      .assignedVehicleNumberController.text)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey.shade500,
                                    shape: const StadiumBorder()),
                                onPressed: () {
                                  Get.to(ReadyToPickup(
                                    source: widget.source,
                                    destination: widget.destination,
                                    pickupDateTime: widget.pickupDateTime,
                                    returnDateTime: widget.returnDateTime,
                                    delivery: widget.delivery,
                                    purpose: widget.purpose,
                                    ownerName: widget.ownerName,
                                    ownerPhoneNumber: widget.ownerPhoneNumber,
                                    type: widget.type,
                                    vehicleNumber: widget.vehicleNumber,
                                    vehicleName: widget.vehicleName,
                                    seats: widget.seats,
                                    rentalPrice: widget.rentalPrice,
                                    base_12: widget.base_12,
                                    base_24: widget.base_24,
                                  ));
                                },
                                child: const Text(
                                  'Pay',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                          ),
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    shape: const StadiumBorder()),
                                onPressed: () {},
                                child: const Text(
                                  'Cancel Ride',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // Get.to(HomePage());
                            Get.to(PickupVehicle(
                              source: widget.source,
                              destination: widget.destination,
                              pickupDateTime: widget.pickupDateTime,
                              returnDateTime: widget.returnDateTime,
                              delivery: widget.delivery,
                              purpose: widget.purpose,
                              ownerName: widget.ownerName,
                              ownerPhoneNumber: widget.ownerPhoneNumber,
                              type: widget.type,
                              vehicleNumber: widget.vehicleNumber,
                              vehicleName: widget.vehicleName,
                              seats: widget.seats,
                              rentalPrice: widget.rentalPrice,
                              base_12: widget.base_12,
                              base_24: widget.base_24,
                            ));
                          },
                          child: const Text('Pay at Pickup')),
                    ],
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
