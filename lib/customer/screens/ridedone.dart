import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:need_moto/customer/controllers/vehicleSubmitController.dart';
import 'package:need_moto/customer/screens/submitVehicle.dart';


class RideComplete extends StatefulWidget {

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

  RideComplete({
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
  });


  @override
  State<RideComplete> createState() => _RideCompleteState();
}

class _RideCompleteState extends State<RideComplete> {
  final _readingController = TextEditingController();

  final _fastTagController = TextEditingController();

  final _damageController = TextEditingController();

  final _dateController = TextEditingController();

  final _messageController = TextEditingController();

  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy HH:mm');

  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  String? _selectedOption;


  VehicleSubmitController vehicleSubmitController = Get.find();

  @override
  Widget build(BuildContext context) {
    final _currentIndex = 0.obs;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'HANDOVER VEHICLE',
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
        child: Container(
          color: Colors.white,
          child: Column(children: [
            Divider(
              color: Colors.black,
              thickness: 0.3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 30, right: 30),
              child: Column(
                children: [
                  TextFormField(
                    controller: vehicleSubmitController.vehicleReadingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      labelText: 'Reading',
                    ),
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Scratches',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    value: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                        vehicleSubmitController.vehicleScratchController.text = value.toString();
                      });
                    },
                    items: options
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: vehicleSubmitController.vehicleDamageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      labelText: 'Damages',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: vehicleSubmitController.vehicleFastTagAmountController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      labelText: 'Fast Tag amount',
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: vehicleSubmitController.vehicleDateTimeOfHandoverController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          labelText: 'Date and time of Handover',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: vehicleSubmitController.vehicleMessageController,
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
                          print(vehicleSubmitController.vehicleDateTimeOfHandoverController.text);
                          vehicleSubmitController.extractSubmitDateAndTime(vehicleSubmitController.vehicleDateTimeOfHandoverController.text);
                          Get.to(() => SubmitVehicle(
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
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
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
  }

}
