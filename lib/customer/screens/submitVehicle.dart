import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/controllers/vehicleSubmitController.dart';
import 'package:need_moto/customer/screens/rateOwner.dart';

class SubmitVehicle extends StatefulWidget {
  final String vehicleNumber;
  final String ownerPhoneNumber;
  final String ownerName;
  final String base_12;
  final String base_24;

  const SubmitVehicle({
    super.key,
    required this.vehicleNumber,
    required this.ownerName,
    required this.ownerPhoneNumber,
    required this.base_12,
    required this.base_24,
  });

  @override
  State<SubmitVehicle> createState() => _SubmitVehicleState();
}

class _SubmitVehicleState extends State<SubmitVehicle> {
  final ValueNotifier<bool> _checkboxNotifier = ValueNotifier(false);

  VehicleSubmitController vehicleSubmitController = Get.find();

  MainController mainController = Get.find();
  double totalHours = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vehicleSubmitController.vehicleTotalDurationController.text =
        vehicleSubmitController.calculateDuration(
            mainController.pickupDateTime.text,
            vehicleSubmitController.vehicleDateTimeOfHandoverController.text);
    calculateExtraPrice();
  }

  void calculateExtraPrice() {
    double hourlyRate = 0.0;

    totalHours = vehicleSubmitController
        .calculateExtraTime(mainController.returnDateTime.text,
            vehicleSubmitController.vehicleDateTimeOfHandoverController.text)
        .toDouble();

    print('TOTAL HOURS: $totalHours');
    // if vehicle submitted before return date time
    if (totalHours < 0) {
      vehicleSubmitController.vehicleOtherChargesController.text = '0.0';
    } else {
      print(mainController.userChoiceHoursController.text);
      // price for different base -> 12 and 24
      if (mainController.userChoiceHoursController.text == '12') {
        setState(() {
          hourlyRate = double.parse(widget.base_12);
        });
        print('HOURLY RATE 12 HOURS: $hourlyRate');
      } else if (mainController.userChoiceHoursController.text == '24') {
        setState(() {
          hourlyRate = double.parse(widget.base_24);
        });
        print('HOURLY RATE 24 HOURS: $hourlyRate');
      }

      print(mainController.userChoiceHoursController.text);
      print("HOURLY RATE: $hourlyRate");
      double extraPrice = totalHours * hourlyRate;
      print("EXTRA PRICE: $extraPrice");
      setState(() {
        vehicleSubmitController.vehicleOtherChargesController.text =
            extraPrice.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'VEHICLE SUBMISSION',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          leading: IconButton(
            icon: const Icon(
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
                        '₹${vehicleSubmitController.vehicleOtherChargesController.text}',
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Extra Charges',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  top: 8.0, bottom: 8, left: 85, right: 85),
                              child: Text(
                                'Pay',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
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
                        const Text(
                          'Received Date',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text(
                            vehicleSubmitController
                                .vehicleReceivedDateController.text,
                            style: const TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Time',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text(
                            vehicleSubmitController
                                .vehicleReceivedTimeController.text,
                            style: const TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Reading',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text(
                            vehicleSubmitController
                                .vehicleReadingController.text,
                            style: const TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Duration',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text(
                            '${vehicleSubmitController.vehicleTotalDurationController.text} Hours',
                            style: const TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Submitted Date',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text(
                            vehicleSubmitController
                                .vehicleSubmitDateController.text,
                            style: const TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Time',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text(
                            vehicleSubmitController
                                .vehicleSubmitTimeController.text,
                            style: const TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Scratches',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text(
                            vehicleSubmitController
                                .vehicleScratchController.text,
                            style: const TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Damages',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text(
                            vehicleSubmitController
                                .vehicleDamageController.text,
                            style: const TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Fasttag amount',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text(
                            vehicleSubmitController
                                .vehicleFastTagAmountController.text,
                            style: const TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Other Charges',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          totalHours < 0 ? 'No' : 'Yes',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Message',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.25,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(vehicleSubmitController
                                .vehicleMessageController.text),
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
                  const Text(
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
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 85, right: 85),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
