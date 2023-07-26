import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/vehicleSubmitController.dart';
import 'package:need_moto/customer/screens/ridedone.dart';

class RideStart extends StatefulWidget {
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

  const RideStart({
    super.key,
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
  State<RideStart> createState() => _RideStartState();
}

class _RideStartState extends State<RideStart> {
  VehicleSubmitController vehicleSubmitController = Get.find();

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.18,
              color: const Color.fromRGBO(51, 204, 102, 1),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(85, 212, 127, 1)),
                  child: const Text(
                    "Your ride is started",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reading",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "5 Km",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ride Completing Time",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "23.5 hrs",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              // height: MediaQuery.of(context).size.height * 0.16,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromRGBO(227, 250, 166, 1)),
              child: Text(
                "Your 4 digit OTP is ${vehicleSubmitController.vehicleOTPController.text}. Please share with owner.",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    height: 1.25,
                    fontWeight: FontWeight.w500),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.orange[600]),
              ),
              onPressed: () {
                //

                Get.to(RideComplete(
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
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: const Center(
                  child: Text(
                    "Ride Complete",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            widget.ownerName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "+91 ${widget.ownerPhoneNumber}",
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
                          style: TextStyle(color: Colors.black54, fontSize: 18),
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
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                        Text(
                          widget.vehicleNumber,
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
          ],
        ),
      ),
    );
  }
}
