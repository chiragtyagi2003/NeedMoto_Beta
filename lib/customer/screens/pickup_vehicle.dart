import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/Request_Controller.dart';
import 'package:need_moto/customer/controllers/vehicleSubmitController.dart';
import 'package:need_moto/customer/screens/home2.dart';
import 'package:need_moto/customer/screens/ready_to_pickup.dart';
import 'package:need_moto/customer/screens/ride_start.dart';

class PickupVehicle extends StatefulWidget {

  String source;
  String destination;
  String pickupDateTime;
  String returnDateTime;
  String delivery;
  String purpose;
  String ownerName;
  String ownerPhoneNumber;
  String type;
  String vehicleNumber;
  String vehicleName;
  String seats;
  double rentalPrice;
  String base_12;
  String base_24;

  PickupVehicle({
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

  @override
  Widget build(BuildContext context) {
    final Rxn<bool> selected = Rxn<bool>();

    VehicleSubmitController vehicleSubmitController  = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(51, 204, 102, 1),
        title: Text(
          "Payment done ₹${widget.rentalPrice}",
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.085,
            color: Color.fromRGBO(51, 204, 102, 1),
            // color: Colors.red,
            child: Container(
                margin: EdgeInsets.only(bottom: 20, left: 45, right: 45),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                decoration:
                    BoxDecoration(color: Color.fromRGBO(85, 212, 127, 1)),
                child: Center(
                  child: Text(
                    "Vehicle is ready for move to your location",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          SizedBox(height: 10.0,),
          Container(
            height: MediaQuery.of(context).size.height * 0.27,

            child: Image.asset('assets/images/tick.png'),
            //decoration: BoxDecoration(color: Colors.red),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(230, 230, 230, 1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: Center(
                      child: Text(
                        '${widget.vehicleName} / ${widget.seats} Seater / ${widget.rentalPrice}/-',
                    style: TextStyle(fontSize: 18),
                  )),
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            // color: Colors.amber,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Form",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                Text(
                                  "${widget.source}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.compare_arrows,
                            color: Colors.orange,
                            size: 35,
                          ),
                          Container(
                            // color: Colors.orangeAccent,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To:",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                Text(
                                  "${widget.destination}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            // color: Colors.amber,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
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
                                      "${widget.pickupDateTime}",
                                      style: TextStyle(fontSize: 18),
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
                          Icon(
                            Icons.calendar_month,
                            color: Colors.orange,
                            size: 25,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
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
                                      "${widget.returnDateTime}",
                                      style: TextStyle(fontSize: 18),
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
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            // color: Colors.amber,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Vehicle home delivery or Pickup",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                Text(
                                  "${widget.delivery}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // color: Colors.orangeAccent,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Purpose",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                Text(
                                  "${widget.purpose}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                  // height: 100,
                  decoration: BoxDecoration(
                    boxShadow: [
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
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey)),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                              Text(
                                "${widget.ownerName}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "+91 ${widget.ownerPhoneNumber}",
                                style: TextStyle(
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
                                    icon: Icon(
                                      Icons.mail_outline,
                                      color: Colors.orange,
                                    )),
                              ),
                              SizedBox(width: 10),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.call_outlined,
                                      color: Colors.green,
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Fuel type",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                            ),
                            Text(
                              "${widget.type}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Vehicle number",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                            ),
                            Text(
                              "${widget.vehicleNumber}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Message",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                        SizedBox(height: 7),
                        Text(
                          "Vehicle is moving to your door step",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        SizedBox(height: 20),
                        Row(
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
                        SizedBox(height: 7),
                        Text(
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
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  height: MediaQuery.of(context).size.height * 0.16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromRGBO(227, 250, 166, 1)),
                  child: Column(
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
          Divider(
            color: Colors.black87,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Obx(
                  () => Checkbox(
                    activeColor: Color.fromARGB(255, 33, 103, 243),
                    value: selected.value == true,
                    onChanged: (val) {
                      val == true
                          ? selected.value = true
                          : selected.value = false;
                    },
                  ),
                ),
                Text(
                  "I accept ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Terms and conditions",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
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
                      MaterialStateProperty.all(Color.fromRGBO(2, 100, 171, 1)),
                ),
                onPressed: () {
                  vehicleSubmitController.vehicleReceivedDateTimeController.text = DateTime.now().toString();
                  print(vehicleSubmitController.vehicleReceivedDateTimeController.text);
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
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.33,
                  height: 50,
                  child: Center(
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
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.33,
                  height: 50,
                  child: Center(
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
          SizedBox(height: 20),
        ]),
      ),
    );
  }
}
