import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/controllers/DateController.dart';
import 'package:need_moto/controllers/Dropdown.dart';
import 'package:need_moto/screens/AddVehicle.dart';
import 'package:need_moto/screens/AdminBookings.dart';
import 'package:need_moto/screens/AllVehicles.dart';
import 'package:need_moto/screens/Payments.dart';
import 'package:need_moto/screens/Requests.dart';
import 'package:need_moto/widget/myappbar.dart';

class AdminHome extends StatelessWidget {
  AdminHome({super.key});
  TextEditingController _vehicleNeedLocations = TextEditingController();
  TextEditingController _vehicleSource = TextEditingController();
  TextEditingController _vehicleDestination = TextEditingController();
  TextEditingController _pickupDateTime = TextEditingController();
  TextEditingController _returnDateTime = TextEditingController();
  TextEditingController _delivery = TextEditingController();
  TextEditingController _purpose = TextEditingController();
  DropdownController controller = DropdownController();
  //Dropdown Controller
  DropdownController controllers = DropdownController();
  // DateTimeController Controller = DateTimeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: GestureDetector(
                    child: returnCard("assets/Vehicles.jpg"),
                    onTap: () {
                      Get.to(MyWidget(
                        seats: controllers.selectedItem,
                        delivery: _delivery.text,
                        vehicleLocation: _vehicleNeedLocations.text,
                        source: _vehicleSource.text,
                        destination: _vehicleDestination.text,
                        pickupDateTime: _pickupDateTime.text,
                        returnDateTime: _returnDateTime.text,
                        purpose: _purpose.text,
                      ));
                    },
                  )),
                  Expanded(
                      child: GestureDetector(
                          child: returnCard("assets/Book.jpg"),
                          onTap: () {
                            Get.to(AdminBookings());
                          }))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'All Vehicles',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Text('Bookings',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                        child: returnCard("assets/Requests.jpg"),
                        onTap: () {
                          Get.to(Requests());
                        }),
                  ),
                  Expanded(
                      child: GestureDetector(
                          child: returnCard("assets/pay.jpg"),
                          onTap: () {
                            Get.to(Payments());
                          }))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Requests',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  Text('Payments',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                  onTap: () {
                    Get.to(() => AddVehicle());
                  },
                  child: Container(
                    width: 250,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.orangeAccent],
                            stops: [0.1, 0.7]),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Text(
                        'Add Vehicle',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
            ],
          ),
        )),
      ),
    );
  }
}

Widget returnCard(String image) {
  return // 1. Local image
      Padding(
    padding: const EdgeInsets.all(5.0),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Container(
        height: 175,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
        ),
      ),
    ),
  );
// 2. Image from Internet
}
