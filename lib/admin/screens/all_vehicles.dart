import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:need_moto/admin/controllers/admin_main_controller.dart';
import 'package:need_moto/admin/widget/vehicle_tile_1.dart';
import 'package:need_moto/admin/widget/vehicle_tile_2.dart';
import 'package:need_moto/customer/controllers/VehicleBookingController.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';


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
  AdminMainController mainController = Get.find();
  VehicleBookingController vehicleBookingController = Get.find();

  @override
  void initState() {
    super.initState();
    mainController.fetchVehicleData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... your existing code
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
                        returnDetail('Total', Colors.blue, mainController.totalVehiclesController.text),
                        returnDetail('Booked', Colors.red, mainController.bookedVehiclesController.text),
                        returnDetail('Available', Colors.green, mainController.availableVehiclesController.text),
                      ],
                    ),
                  ),
                ),
              ),

              Obx(
                    () =>
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: mainController.vehicleList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var vehicleDoc = mainController.vehicleList[index];

                        // Access the fields within the document
                        late String brandName;
                        late String model;
                        late String seating;
                        late String pricePerDay;
                        late String distanceRange;
                        late String average;
                        late String kmpl;
                        late String type;
                        late String ownerName;
                        late String ownerPhoneNumber;
                        late String vehicleNumber;
                        late bool booked;

                        try {
                          brandName = vehicleDoc['brandName'] ?? "N/A";
                          model = vehicleDoc['model'] ?? "N/A";
                          seating = vehicleDoc['seating'] ?? "N/A";
                          pricePerDay = vehicleDoc['pricePerDay'] ?? "N/A";
                          distanceRange = vehicleDoc['distanceRange'] ?? "N/A";
                          average = vehicleDoc['average'] ?? "N/A";
                          kmpl = vehicleDoc['kmpl'] ?? "N/A";
                          type = vehicleDoc['type'] ?? "N/A";
                          ownerName = vehicleDoc['ownerName'] ?? "N/A";
                          ownerPhoneNumber = vehicleDoc['ownerPhoneNumber'] ?? "N/A";
                          booked = vehicleDoc['onRide'] as bool;
                          vehicleNumber = vehicleDoc['vehicleNumber'] ?? 'N/A';
                        } catch (e) {
                          // Print the exception to identify which field caused the error
                          print("Error accessing fields: $e");
                        }

                        return VehicleTile2(
                          imgUrl: 'https://cdni.autocarindia.com/utils/imageresizer.ashx?n=https://cms.haymarketindia.net/model/uploads/modelimages/Hyundai-Grand-i10-Nios-200120231541.jpg&w=872&h=578&q=75&c=1',
                          vehicleName: "$brandName $model",
                          seats: seating,
                          rentalPricePerDay: pricePerDay,
                          perKm: distanceRange,
                          distanceFromYou: "2.5",
                          kmpl: kmpl,
                          type: type,
                          ownerName: ownerName,
                          ownerPhoneNumber: ownerPhoneNumber,
                          average: average,
                          booked: booked,
                          vehicleNumber: vehicleNumber,
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
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