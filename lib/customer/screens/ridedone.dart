import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:need_moto/customer/controllers/vehicleSubmitController.dart';
import 'package:need_moto/customer/screens/submitVehicle.dart';

class RideComplete extends StatefulWidget {
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

  const RideComplete({
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
  State<RideComplete> createState() => _RideCompleteState();
}

class _RideCompleteState extends State<RideComplete> {
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy HH:mm');

  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  String? _selectedOption;

  VehicleSubmitController vehicleSubmitController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'HANDOVER VEHICLE',
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
        child: Container(
          height: MediaQuery.sizeOf(context).height * 1.0,
          color: Colors.white,
          child: Column(children: [
            const Divider(
              color: Colors.black,
              thickness: 0.3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 30, right: 30),
              child: Column(
                children: [
                  TextFormField(
                    controller:
                        vehicleSubmitController.vehicleReadingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      labelText: 'Reading',
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Scratches',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    value: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                        vehicleSubmitController.vehicleScratchController.text =
                            value.toString();
                      });
                    },
                    items: options
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: vehicleSubmitController.vehicleDamageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      labelText: 'Damages',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller:
                        vehicleSubmitController.vehicleFastTagAmountController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      labelText: 'Fast Tag amount',
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: vehicleSubmitController
                            .vehicleDateTimeOfHandoverController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          labelText: 'Date and time of Handover',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller:
                        vehicleSubmitController.vehicleMessageController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Message',
                      hintText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
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
                          vehicleSubmitController.extractSubmitDateAndTime(
                              vehicleSubmitController
                                  .vehicleDateTimeOfHandoverController.text);

                          Get.to(() => SubmitVehicle(
                                vehicleNumber: widget.vehicleNumber,
                                ownerName: widget.ownerName,
                                ownerPhoneNumber: widget.ownerPhoneNumber,
                                base_12: widget.base_12,
                                base_24: widget.base_24,
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
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
           vehicleSubmitController.recordVideo();
        },
        child: Icon(Icons.video_camera_back_outlined),
        ),
      );
  }

  Future<void> _selectDate(BuildContext context) async {
    try {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );

      if (pickedDate != null) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          DateTime selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          vehicleSubmitController.vehicleDateTimeOfHandoverController.text =
              _dateFormat.format(selectedDateTime);
        }
      }
    } catch (e) {
      // Handle any errors that occur during date and time selection
      Fluttertoast.showToast(
        msg: 'Error.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
      // You can show an error message to the user or handle the error in another way.
    }
  }
}
