import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/admin/controllers/admin_add_vehicle_Controller.dart';

import 'package:need_moto/admin/widget/my_appbar.dart';

class AddVehicle extends StatefulWidget {
  String vehicleId;

  AddVehicle({
    super.key,
    required this.vehicleId,
  });

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  AdminAddVehicleController adminAddVehicleController = Get.find();
  late Future<DocumentSnapshot<Map<String, dynamic>>> vehicleDataFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Initialize the future in the initState method
    vehicleDataFuture =
        adminAddVehicleController.fetchVehicleDetails(widget.vehicleId);
  }

  //Options display
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const Drawer(
        child: Text('drawer'),
      ),
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
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: adminAddVehicleController.brand,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Company'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: adminAddVehicleController.model,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Model'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: adminAddVehicleController.vehicleNumber,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Vehicle Number'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: adminAddVehicleController.vehicleTypeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Vehicle Type'),
                        ),
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
                          ),
                          items: adminAddVehicleController
                              .dropDowncontroller.options,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            labelText: 'Seats',
                          )),
                          onChanged: (value) {
                            adminAddVehicleController.dropDowncontroller
                                .setValue(value!);
                          },
                          selectedItem: adminAddVehicleController
                              .dropDowncontroller.selectedItem,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: adminAddVehicleController.average,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Average Speed'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: adminAddVehicleController.kmpl,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Mileage(kmpl)'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: adminAddVehicleController.distanceRange,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Range'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      SizedBox(
                        width: 350,
                        height: 60,
                        child: SizedBox(
                          height: 100,
                          child: TextField(
                            controller: adminAddVehicleController.ownerName,
                            maxLines: null,
                            // Set this
                            expands: true,
                            // and this
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                labelText: 'Owner name'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: adminAddVehicleController.base12,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Base price (12 hrs)'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: adminAddVehicleController.base24,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Base price (24 hrs)'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: adminAddVehicleController.pricePerDay,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Price per day'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: adminAddVehicleController.pricePerKm,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Price per km'),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: adminAddVehicleController.pricePerHour,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Price per Hour'),
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      TextField(
                          controller: adminAddVehicleController.description,
                          maxLines: 5,
                          minLines: 3,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Description')),
                      const SizedBox(
                        height: 25,
                      ),
                      //car details display button
                      GestureDetector(
                          onTap: () async {
                            try {
                              await adminAddVehicleController
                                  .addVehicleToCollection(widget.vehicleId);
                            } catch (e) {
                              Get.snackbar(
                                'Error',
                                'Failed to add vehicle. Please try again later.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
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
