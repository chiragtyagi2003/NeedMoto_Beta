import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';

import 'package:need_moto/customer/screens/chooseVehicle.dart';
import 'package:need_moto/customer/screens/customer_side_drawer.dart';

import 'package:intl/intl.dart';
import 'package:need_moto/customer/widget/myappbar.dart';


class SelfDrive extends StatefulWidget {
  @override
  State<SelfDrive> createState() => _SelfDriveState();
}

class _SelfDriveState extends State<SelfDrive> {

  MainController mainController = Get.find();

  //Options display
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: CustomerSideDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(10)),

                Text(
                  'Enter Vehicle Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                //Customer details

                SizedBox(
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
                          popupProps: PopupProps.menu(
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
                            mainController.seatsDropDownController.setValue(value!);
                            mainController.filterSeats = value!;
                          },
                          selectedItem: mainController.seatsDropDownController.selectedItem,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
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
                      SizedBox(
                        height: 25,
                      ),
                      Container(
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
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: Obx(() => TextField(
                              controller: mainController.pickupDateTime..text = DateFormat('dd-MM-yyyy HH:mm')
                              .format(mainController.pickUpdateTimeController.selectedDateTime.value)
                              .toString(),
                              readOnly: true,
                              onTap: () async {
                              final selectedDateTime = await mainController.pickUpdateTimeController.selectDateTime(context);
                                if (selectedDateTime != null) {
                                  mainController.pickupDateTime.text = DateFormat('dd-MM-yyyy HH:mm').format(selectedDateTime);
                                print('pickup date time: ${mainController.pickupDateTime.text}');
                                print('pickup date time: ${mainController.pickupDateTime.text}');
                                }},
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  labelText: 'Pickup date & Time'),
                            )
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      Container(
                        width: 350,
                        height: 60,
                        child: Obx(() => TextField(
                          controller: mainController.returnDateTime..text = DateFormat('dd-MM-yyyy HH:mm')
                              .format(mainController.returndateTimeController.selectedDateTime.value)
                              .toString(),
                          readOnly: true,
                          onTap: () async {
                            final selectedDateTime = await mainController.returndateTimeController.selectDateTime(context);
                            if (selectedDateTime != null) {
                              mainController.returnDateTime.text = DateFormat('dd-MM-yyyy HH:mm').format(selectedDateTime);
                              print('return date time: ${mainController.returnDateTime.text}');
                            }},
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Return date & Time'),
                        )
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        //Controller usage
                        child: DropdownSearch(
                          popupProps: PopupProps.menu(
                              constraints: BoxConstraints(maxHeight: 200),
                              searchDelay: Duration(milliseconds: 500)),
                          items: mainController.deliveryDropDownController.option,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            labelText: 'Delivery',
                          )),
                          onChanged: (value) {
                            mainController.deliveryDropDownController.setvalue(value!);
                            mainController.delivery.text = value!;
                            print('delivery: ${mainController.delivery.text}');
                          },
                          selectedItem: mainController.deliveryDropDownController.selectType,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
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
                      SizedBox(
                        height: 25,
                      ),
                      //car details display button
                      GestureDetector(
                          onTap: () {

                            String pickupTime = mainController.pickupDateTime.text;
                            String returnTime = mainController.returnDateTime.text;
                            // call the function to calculate days and hours time
                            mainController.calculateTimeDifference(pickupTime, returnTime);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChooseVehicle(
                                          // seats: mainController.seatsDropDownController.selectedItem,
                                          // delivery: mainController.delivery.text,
                                          // vehicleLocation: mainController.vehicleNeedLocations.text,
                                          // source: mainController.vehicleSource.text,
                                          // destination: mainController.vehicleDestination.text,
                                          // pickupDateTime: mainController.pickupDateTime.text,
                                          // returnDateTime: mainController.returnDateTime.text,
                                          // purpose: mainController.purpose.text,
                                        )));
                          },
                          child: Container(
                            width: 250,
                            height: 50,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.orange,
                                  Colors.orangeAccent
                                ], stops: [
                                  0.1,
                                  0.7
                                ]),
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
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

                SizedBox(
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
