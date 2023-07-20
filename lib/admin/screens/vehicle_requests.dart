import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/admin/controllers/admin_main_controller.dart';
import 'package:need_moto/admin/widget/vehicle_tile_1.dart';
import 'package:need_moto/main.dart';
import '../../customer/widget/myappbar.dart';

class VehicleRequests extends StatefulWidget {
  @override
  State<VehicleRequests> createState() => _VehicleRequestsState();
}

class _VehicleRequestsState extends State<VehicleRequests> {

  AdminMainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
               Container(
                  height: 400,
                  child: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                    future: fetchVehicleRequests(), // Call the function to fetch the vehicles
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error fetching data'));
                      } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return Center(child: Text('No vehicles to display'));
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var vehicleSnapshot = snapshot.data![index];
                          mainController.vehicleNameController.text = vehicleSnapshot['vehicleName'];
                          mainController.ownerNameController.text = vehicleSnapshot['ownerName'];
                          //mainController.vehicleSeatsController.text = vehicleSnapshot['seating'];
                          return VehicleTile1(
                            //  pass the vehicleSnapshot to VehicleTile1 and access its data inside the widget
                            vehicleSnapshot: vehicleSnapshot,

                          );
                        },
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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchVehicleRequests() async {
    // Query the vehicles collection where adminApproval is false
    var querySnapshot = await FirebaseFirestore.instance.collection('vehicles').where('adminApproval', isEqualTo: false).get();

    // Return the list of documents
    return querySnapshot.docs;
  }
}
