import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/controllers/main_controller.dart';

class AdminDashboard extends StatelessWidget {
  MainController mainController = Get.find();

  void submitForm() {
    String vehicleNumber = mainController.vehicleNumberController.text;
    String brandName = mainController.brandNameController.text;
    String modelName = mainController.modelNameController.text;
    String average = mainController.averageController.text;
    String desc = mainController.descController.text;
    String distanceRange = mainController.distanceRangeController.text;
    String KPML = mainController.kpmlController.text;
    String ownerName = mainController.ownerNameController.text;
    String ownerPhoneNumber = mainController.ownerPhoneNumberController.text;
    String pricePerDay = mainController.rentalPricePerDayController.text;
    String pricerPerKm = mainController.rentalPricePerKmController.text;
    String seating = mainController.seatsController.text;
    String type = mainController.typeController.text;
    String pricePerKmCust = mainController.pricePerKmCust.text;
    String pricePerHourCust = mainController.pricePerHourCust.text;
    String base_12 = mainController.base12PriceController.text;
    String base_24 = mainController.base24PriceController.text;
    // Get the rest of the form data in a similar way

    // Create a new document reference with the vehicle number as the document ID
    DocumentReference vehicleRef =
    FirebaseFirestore.instance.collection('vehicles').doc(vehicleNumber);

    // Create a map of the data to be stored in the document
    Map<String, dynamic> vehicleData = {
      'brandName': brandName,
      'modelName': modelName,
      'average' : average,
      'desc' : desc,
      'distanceRange': distanceRange,
      'kpml' : KPML,
      'ownerName': ownerName,
      'ownerPhoneNumber': ownerPhoneNumber,
      'pricePerDay': pricePerDay,
      'pricerPerKm': pricerPerKm,
      'seating': seating,
      'type': type,
      'pricePerKmCust': pricePerKmCust,
      'pricePerHourCust': pricePerHourCust,
      'base_12': base_12,
      'base_24': base_24,
      // Add the rest of the form data fields to the map
    };

    // Set the data in the Firestore document
    vehicleRef.set(vehicleData)
        .then((value) {
      // Document created successfully
      // You can add any additional actions or navigate to another screen here
      mainController.vehicleNumberController.text = " ";
      mainController.brandNameController.text = " ";
      mainController.modelNameController.text = "";
      mainController.averageController.text =" ";
      mainController.descController.text = " ";
      mainController.distanceRangeController.text = " ";
      mainController.kpmlController.text = " ";
      mainController.ownerNameController.text = " ";
      mainController.ownerPhoneNumberController.text = " ";
      mainController.rentalPricePerDayController.text = " ";
      mainController.rentalPricePerKmController.text = " ";
      mainController.seatsController.text = " ";
      mainController.typeController.text = " ";
      mainController.base24PriceController.text = "";
      mainController.base12PriceController.text = "";
      mainController.pricePerHourCust.text = "";
      mainController.pricePerKmCust.text = "";
    })
        .catchError((error) {
      // An error occurred while creating the document
      // Handle the error appropriately
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.vehicleNumberController,
                    //keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Vehicle Number',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.brandNameController,
                    decoration: InputDecoration(
                      labelText: 'Brand Name',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.modelNameController,
                    //keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Model Name',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.averageController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Average',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.descController,
                   // keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.distanceRangeController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Distance Range',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.kpmlController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'KPML',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.ownerNameController,
                    //keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Owner Name',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.ownerPhoneNumberController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Owner Phone Number',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.rentalPricePerKmController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Rental Price/km',
                    ),
                  ),


                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.rentalPricePerDayController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Rental Price/Day',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.seatsController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Number of Seats',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.typeController,
                    //keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Type(Diesel, Petrol, CNG)',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.base12PriceController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Base Price 12 hours',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.base24PriceController,
                    //keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Base Price 24 hours',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.pricePerKmCust,
                    //keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'price per Km Customer',
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextField(
                    controller: mainController.pricePerHourCust,
                    //keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Price per Hour Customter',
                    ),
                  ),


                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: submitForm,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
