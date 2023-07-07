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
      appBar:
      AppBar(backgroundColor: Colors.white,
        title: Text( 'choose your vehicle',  style: TextStyle( fontSize: 18,color: Colors.black),),
      ),
      body: SafeArea(
          child: GridView(
          padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 250),
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    mainController.vehicleTypeController.text = 'self-drive';
                  });

                  Get.to(ChooseVehicle());
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black,width: 2.0)),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/rr3.png',
                        width: 190,
                        height: 190,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Self Drive',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
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

                  Get.to(ChooseVehicle());
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black,width: 2.0)),
                  child: Column(
                    children: [
                      Image.asset(
                        '',
                        width: 190,
                        height: 190,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Car',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
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

                  Get.to(ChooseVehicle());
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black,width: 2.0)),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/Truck1.jpg',
                        width: 190,
                        height: 190,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Truck',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
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

                  Get.to(ChooseVehicle());
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black,width: 2.0)),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/Taxi.jpg',
                        width: 190,
                        height: 190,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Taxi',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
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

                  Get.to(ChooseVehicle());
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black,width: 2.0)),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/Bus2.jpg',
                        width: 190,
                        height: 190,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Bus',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
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

                  Get.to(ChooseVehicle());
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black,width: 2.0)),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/Traveller1.jpg',
                        width: 190,
                        height: 190,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Traveller',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
                  ],
                )
              ),
    );
  }
}
