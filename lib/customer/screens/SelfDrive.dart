import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/controllers/vehicleSubmitController.dart';
import 'package:need_moto/customer/screens/Grid.dart';

import 'package:need_moto/customer/screens/customer_side_drawer.dart';

import 'package:intl/intl.dart';
import 'package:need_moto/customer/widget/myappbar.dart';

class SelfDrive extends StatefulWidget {
  const SelfDrive({super.key});

  @override
  State<SelfDrive> createState() => _SelfDriveState();
}

class _SelfDriveState extends State<SelfDrive> {
  MainController mainController = Get.find();

  VehicleSubmitController vehicleSubmitController = Get.find();

  bool areAllFieldsFilled() {
    // Check if each text controller has a non-empty value
    if (mainController.seatsDropDownController.selectedItem.isEmpty||
        mainController.vehicleSource.text.isEmpty ||
        mainController.vehicleDestination.text.isEmpty ||
        mainController.pickupDateTime.text.isEmpty ||
        mainController.returnDateTime.text.isEmpty ||
        mainController.deliveryDropDownController.selectType.isEmpty ||
        mainController.purpose.text.isEmpty) {
      return false;
    }
    return true;
  }

  //Options display
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const CustomerSideDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(10)),

                const Text(
                  'Enter Vehicle Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                //Customer details

                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, bottom: 20, top: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        //Controller usage
                        child: DropdownSearch(
                          popupProps: const PopupProps.menu(
                            constraints: BoxConstraints(maxHeight: 200),
                          ),
                          items: mainController.seatsDropDownController.options,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            labelText: 'Seats',
                          )),
                          onChanged: (value) {
                            mainController.seatsDropDownController
                                .setValue(value!);
                            mainController.filterSeats = value!;
                          },
                          selectedItem: mainController
                              .seatsDropDownController.selectedItem,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: mainController.vehicleSource,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Source'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: mainController.vehicleDestination,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Destination'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: Obx(() => TextField(
                              controller: mainController.pickupDateTime
                                ..text = DateFormat('dd-MM-yyyy HH:mm')
                                    .format(mainController
                                        .pickUpdateTimeController
                                        .selectedDateTime
                                        .value)
                                    .toString(),
                              readOnly: true,
                              onTap: () async {
                                final selectedDateTime = await mainController
                                    .pickUpdateTimeController
                                    .selectDateTime(context);
                                if (selectedDateTime != null) {
                                  mainController.pickupDateTime.text =
                                      DateFormat('dd-MM-yyyy HH:mm')
                                          .format(selectedDateTime);
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  labelText: 'Pickup date & Time'),
                            )),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      SizedBox(
                        width: 350,
                        height: 60,
                        child: Obx(() => TextField(
                              controller: mainController.returnDateTime
                                ..text = DateFormat('dd-MM-yyyy HH:mm')
                                    .format(mainController
                                        .returnDateTimeController
                                        .selectedDateTime
                                        .value)
                                    .toString(),
                              readOnly: true,
                              onTap: () async {
                                final selectedDateTime = await mainController
                                    .returnDateTimeController
                                    .selectDateTime(context);
                                if (selectedDateTime != null) {
                                  mainController.returnDateTime.text =
                                      DateFormat('dd-MM-yyyy HH:mm')
                                          .format(selectedDateTime);
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  labelText: 'Return date & Time'),
                            )),
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        //Controller usage
                        child: DropdownSearch(
                          popupProps: const PopupProps.menu(
                              constraints: BoxConstraints(maxHeight: 200),
                              searchDelay: Duration(milliseconds: 500)),
                          items:
                              mainController.deliveryDropDownController.option,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            labelText: 'Delivery',
                          )),
                          onChanged: (value) {
                            mainController.deliveryDropDownController
                                .setvalue(value!);
                            mainController.delivery.text = value!;
                          },
                          selectedItem: mainController
                              .deliveryDropDownController.selectType,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: mainController.purpose,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Purpose'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      //car details display button
                      GestureDetector(
                          onTap: () {
                            if (areAllFieldsFilled()) {
                              String pickupTime =
                                  mainController.pickupDateTime.text;
                              String returnTime =
                                  mainController.returnDateTime.text;
                              // call the function to calculate days and hours time
                              mainController.calculateTimeDifference(
                                  pickupTime, returnTime);

                              mainController.durationDaysHoursController.text =
                                  mainController.calculateDurationDaysHours(
                                      mainController.pickupDateTime.text,
                                      mainController.returnDateTime.text);

                              Get.to(const Grid());
                            } else {
                              // Show a snackbar if any field is not filled
                              Get.snackbar(
                                  'Error', 'Please fill in all fields');
                            }
                          },
                          child: Container(
                            width: 250,
                            height: 50,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Colors.orange,
                                  Colors.orangeAccent
                                ], stops: [
                                  0.1,
                                  0.7
                                ]),
                                borderRadius: BorderRadius.circular(25)),
                            child: const Center(
                              child: Text(
                                'Find Vehicle',
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
                ),

                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
