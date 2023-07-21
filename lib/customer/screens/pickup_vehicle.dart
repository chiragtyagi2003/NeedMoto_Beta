import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/Request_Controller.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/controllers/vehicleSubmitController.dart';
import 'package:need_moto/customer/screens/ride_start.dart';

class PickupVehicle extends StatefulWidget {

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
  final double rentalPrice;
  final String base_12;
  final String base_24;

  const PickupVehicle({super.key,
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
    required this.base_24,
  });


  @override
  State<PickupVehicle> createState() => _PickupVehicleState();
}

class _PickupVehicleState extends State<PickupVehicle> {

  RequestController requestController = Get.find();
  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Rxn<bool> selected = Rxn<bool>();

    VehicleSubmitController vehicleSubmitController  = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(51, 204, 102, 1),
        title: Text(
          "Payment done ₹${widget.rentalPrice}",
          style: const TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.085,
            color: const Color.fromRGBO(51, 204, 102, 1),
            // color: Colors.red,
            child: Container(
                margin: const EdgeInsets.only(bottom: 20, left: 45, right: 45),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(85, 212, 127, 1)),
                child: const Center(
                  child: Text(
                    "Vehicle is ready for move to your location",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          const SizedBox(height: 10.0,),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,

            child: Image.asset('assets/images/tick.png'),
            //decoration: BoxDecoration(color: Colors.red),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(230, 230, 230, 1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: Center(
                      child: Text(
                        '${widget.vehicleName} / ${widget.seats} Seater / ${widget.rentalPrice}/-',
                    style: const TextStyle(fontSize: 18),
                  )),
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          // color: Colors.amber,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Form",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                              Text(
                                widget.source,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.compare_arrows,
                          color: Colors.orange,
                          size: 35,
                        ),
                        SizedBox(
                          // color: Colors.orangeAccent,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "To:",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                              Text(
                                widget.destination,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          // color: Colors.amber,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Pickup Date and Time",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.pickupDateTime,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  // Text(
                                  //   "12:30",
                                  //   style: TextStyle(
                                  //       fontSize: 15, color: Colors.black54),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.orange,
                          size: 25,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Drop of date and Time",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.returnDateTime,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  // Text(
                                  //   "19:00",
                                  //   style: TextStyle(
                                  //       fontSize: 15, color: Colors.black54),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          // color: Colors.amber,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Vehicle home delivery or Pickup",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                              Text(
                                widget.delivery,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          // color: Colors.orangeAccent,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Purpose",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                              Text(
                                widget.purpose,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                  // height: 100,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12, spreadRadius: 5, blurRadius: 5)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(children: [
                    Stack(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey)),
                                child: const CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                              Text(
                                mainController.assignedOwnerNameController.text,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "+91 ${mainController.assignedOwnerPhoneNumberController.text}",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black54),
                              ),
                              RatingBarIndicator(
                                  rating: 2.5,
                                  itemCount: 5,
                                  itemSize: 25.0,
                                  itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                      )),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.mail_outline,
                                      color: Colors.orange,
                                    )),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.call_outlined,
                                      color: Colors.green,
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Fuel type",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                            ),
                            Text(
                              widget.type,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Vehicle number",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                            ),
                            Text(
                              mainController.assignedVehicleNumberController.text,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Message",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "Vehicle is moving to your door step",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pickup address",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            //map pointer image
                            // Image.asset("")
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.green,
                            )
                          ],
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "5-48/3, Sri lakshmi ganapathi nilayam, Road no. 7, near saibaba temple Boduppal, peerzadiguda, Hyd, Telangana - 500092",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ],
                    )
                  ]),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  height: MediaQuery.of(context).size.height * 0.16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(227, 250, 166, 1)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Submit the ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Required documents",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            " and ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Text(
                        "pickup the vehicle.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "You received a 4 digit OTP as SMS to registered mobile number. Please share with owner while receiving vehicle",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            height: 1.25,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.black87,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Obx(
                  () => Checkbox(
                    activeColor: const Color.fromARGB(255, 33, 103, 243),
                    value: selected.value == true,
                    onChanged: (val) {
                      val == true
                          ? selected.value = true
                          : selected.value = false;
                    },
                  ),
                ),
                const Text(
                  "I accept ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Terms and conditions",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all(const Color.fromRGBO(2, 100, 171, 1)),
                ),
                onPressed: () {
                  vehicleSubmitController.vehicleReceivedDateTimeController.text = DateTime.now().toString();
                  // set the received date and time
                  vehicleSubmitController.extractReceivedDateAndTime(vehicleSubmitController.vehicleReceivedDateTimeController.text);
                  vehicleSubmitController.addFieldsToBooking(requestController.requestIDController.text);
                 Get.to(RideStart(
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.33,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Receive",
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orange[600]),
                ),
                onPressed: () {

                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.33,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Cancel Ride",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
