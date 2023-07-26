import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/screens/chooseVehicle.dart';

class Grid extends StatefulWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'choose your vehicle',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 250),
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                mainController.vehicleTypeController.text = 'self-drive';
              });

              Get.to(ChooseVehicle(vehicleType: mainController.vehicleTypeController.text,));
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 2.0)),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/rr3.jpg',
                    width: 190,
                    height: 190,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Self Drive',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                mainController.vehicleTypeController.text = 'car';
              });

              Get.to(ChooseVehicle(vehicleType: mainController.vehicleTypeController.text,));
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 2.0)),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/car2.jpg',
                    width: 190,
                    height: 190,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Car',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                mainController.vehicleTypeController.text = 'truck';
              });

              Get.to(ChooseVehicle(vehicleType: mainController.vehicleTypeController.text,));
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 2.0)),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Truck1.jpg',
                    width: 190,
                    height: 190,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Truck',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                mainController.vehicleTypeController.text = 'taxi';
              });
              print(mainController.vehicleTypeController.text);
              Get.to(ChooseVehicle(vehicleType: mainController.vehicleTypeController.text,));
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 2.0)),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Taxi.jpg',
                    width: 190,
                    height: 190,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Taxi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                mainController.vehicleTypeController.text = 'bus';
              });

              Get.to(ChooseVehicle(vehicleType: mainController.vehicleTypeController.text,));
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 2.0)),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Bus2.jpg',
                    width: 190,
                    height: 190,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Bus',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                mainController.vehicleTypeController.text = 'traveller';
              });

              Get.to(ChooseVehicle(vehicleType: mainController.vehicleTypeController.text,));
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 2.0)),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Traveller1.jpg',
                    width: 190,
                    height: 190,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Traveller',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
