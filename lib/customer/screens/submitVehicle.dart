import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/controllers/vehicleSubmitController.dart';
import 'package:need_moto/customer/screens/rateOwner.dart';

class SubmitVehicle extends StatefulWidget {

  // String reading;
  // String scratches;
  // String damages;
  // String fast_tag_amt;
  // String date_time_handover;
  // String message;
  String vehicleNumber;
  String ownerPhoneNumber;
  String ownerName;

  SubmitVehicle({
    // required this.reading,
    // required this.scratches,
    // required this.damages,
    // required this.fast_tag_amt,
    // required this.date_time_handover,
    // required this.message,
    required this.vehicleNumber,
    required this.ownerName,
    required this.ownerPhoneNumber,
});

  @override
  State<SubmitVehicle> createState() => _SubmitVehicleState();
}

class _SubmitVehicleState extends State<SubmitVehicle> {
  final ValueNotifier<bool> _checkboxNotifier = ValueNotifier(false);

  VehicleSubmitController vehicleSubmitController = Get.find();


  MainController mainController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vehicleSubmitController.vehicleTotalDurationController.text = vehicleSubmitController.calculateDuration(mainController.pickupDateTime.text, vehicleSubmitController.vehicleDateTimeOfHandoverController.text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'VEHICLE SUBMISSION',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 18.0, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '₹1500.00',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Extra Charges',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade400,
                                Colors.blue.shade700
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8, left: 85, right: 85),
                              child: Text(
                                'Pay',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.4,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Received Date',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text('${vehicleSubmitController.vehicleReceivedDateController.text}',
                            style: TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Time',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text('${vehicleSubmitController.vehicleReceivedTimeController.text}',
                            style: TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reading',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text('${vehicleSubmitController.vehicleReadingController.text}',
                            style: TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Duration',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text('${vehicleSubmitController.vehicleTotalDurationController.text} Hours',
                            style: TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ride Km',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text('500',
                            style: TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Submitted Date',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text('${vehicleSubmitController.vehicleSubmitDateController.text}',
                            style: TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Time',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text('${vehicleSubmitController.vehicleSubmitTimeController.text}',
                            style: TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Scratches',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text('${vehicleSubmitController.vehicleScratchController.text}',
                            style: TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Damages',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text('${vehicleSubmitController.vehicleDamageController.text}',
                            style: TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fasttag amount',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text('${vehicleSubmitController.vehicleFastTagAmountController.text}',
                            style: TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Other Charges',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'No',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Message',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.25,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('${vehicleSubmitController.vehicleMessageController.text}'),
                          ),
                          //
                          // TextField(
                          //   maxLines: 5,
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //     ),
                          //   ),
                          // ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _checkboxNotifier,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return Checkbox(
                        value: value,
                        onChanged: (bool? newValue) {
                          _checkboxNotifier.value = newValue ?? false;
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'I have received all my documents',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade700],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 85, right: 85),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Get.to(RateOwner(
                        vehicleNumber: widget.vehicleNumber,
                        ownerName: widget.ownerName,
                        ownerPhoneNumber: widget.ownerPhoneNumber,

                      ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
