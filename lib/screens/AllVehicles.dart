import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:need_moto/controllers/VehicleBookingController.dart';
import 'package:need_moto/controllers/main_controller.dart';
import 'package:need_moto/widget/vehicleTile.dart';
import 'package:need_moto/widget/vehicleTile1.dart';

class MyWidget extends StatefulWidget {
  MyWidget({
    Key? key,
    required this.seats,
    required this.vehicleLocation,
    required this.source,
    required this.destination,
    required this.pickupDateTime,
    required this.returnDateTime,
    required this.delivery,
    required this.purpose,
  }) : super(key: key);
  RxString seats;
  String vehicleLocation;
  String source;
  String destination;
  String pickupDateTime;
  String returnDateTime;
  String delivery;
  String purpose;
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  MainController mainController = Get.find();
  VehicleBookingController vehicleBookingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, bottom: 8, left: 10, right: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {},
                child: Text('View on map')),
          )
        ],
        title: Text(
          'All Vehicles',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            returnDetail('Total', Colors.blue, '56'),
                            returnDetail('Booked', Colors.red, '34'),
                            returnDetail('Available', Colors.green, '12'),
                          ]),
                    ),
                  ),
                ),
                Obx(
                  () => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: vehicleBookingController.filteredCars.length,
                    itemBuilder: (BuildContext context, int index) {
                      var car = vehicleBookingController.filteredCars[index];

                      mainController.imgUrlController.text =
                          'https://cdni.autocarindia.com/utils/imageresizer.ashx?n=https://cms.haymarketindia.net/model/uploads/modelimages/Hyundai-Grand-i10-Nios-200120231541.jpg&w=872&h=578&q=75&c=1';
                      mainController.vehicleNameController.text =
                          "${car["brandName"]} ${car["model"]}";
                      mainController.seatsController.text = car["seating"];
                      mainController.rentalPricePerKmController.text =
                          car["pricePerDay"];
                      mainController.perKmController.text =
                          car["distanceRange"];
                      mainController.distanceFromYouController.text = "2.5";
                      mainController.averageController.text = car["average"];
                      mainController.kpmlController.text = car["kpml"];
                      mainController.typeController.text = car["type"];
                      mainController.ownerNameController.text =
                          car["ownerName"];
                      mainController.ownerPhoneNumberController.text =
                          "9999223222";

                      return VehicleTile1(
//key: ValueKey(index),
                          imgUrl: mainController.imgUrlController.text,
                          vehicleName:
                              mainController.vehicleNameController.text,
                          seats: mainController.seatsController.text,
                          rentalPricePerKm:
                              mainController.rentalPricePerKmController.text,
                          perKm: mainController.perKmController.text,
                          distanceFromYou:
                              mainController.distanceFromYouController.text,
                          kpml: mainController.kpmlController.text,
                          type: mainController.typeController.text,
                          ownerName: mainController.ownerNameController.text,
                          ownerPhoneNumber:
                              mainController.ownerPhoneNumberController.text,
                          average: mainController.averageController.text,
                          ////
                          delivery: widget.delivery,
                          source: widget.source,
                          destination: widget.destination,
                          pickupDateTime: widget.pickupDateTime,
                          returnDateTime: widget.returnDateTime,
                          purpose: widget.purpose,
                          vehicleLocation: widget.vehicleLocation,
                          userseats: widget.seats,
                          booked: true);
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

Widget returnDetail(String title, Color color, String number) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                number,
                style: TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
  );
// 2. Image from Internet
}
