import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/VehicleBookingController.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import '../widget/distanceslider.dart';
import '../widget/myappbar.dart';
import '../widget/userchoiceseats.dart';
import '../widget/vehicleTile.dart';

class ChooseVehicle extends StatefulWidget {

  final String vehicleType;

  ChooseVehicle({
    required this.vehicleType,
});

  @override
  State<ChooseVehicle> createState() => _ChooseVehicleState();
}

class _ChooseVehicleState extends State<ChooseVehicle> {
  MainController mainController = Get.find();
  VehicleBookingController vehicleBookingController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    print('Type: ${mainController.vehicleTypeController.text}');
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    try {
      await vehicleBookingController.loadAllCars(mainController.vehicleTypeController.text);
      vehicleBookingController.filterCars("4");
    } catch (e) {
      // Handle any errors that may occur during data loading
      // You can show an error message to the user or handle the error in another way.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text(mainController.durationDaysHoursController.text),
            const SizedBox(
              height: 10.0,
            ),
            DistanceSlider(),
            const SizedBox(
              height: 10.0,
            ),
            const Divider(
              thickness: 1,
            ),
            UserChoiceSeats(),
            const Divider(
              thickness: 1,
            ),
            Obx(
              () => SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: vehicleBookingController.filteredCars.length,
                  itemBuilder: (BuildContext context, int index) {
                    try {
                      var car = vehicleBookingController.filteredCars[index];

                      mainController.imgUrlController.text =
                          'https://cdni.autocarindia.com/utils/imageresizer.ashx?n=https://cms.haymarketindia.net/model/uploads/modelimages/Hyundai-Grand-i10-Nios-200120231541.jpg&w=872&h=578&q=75&c=1';
                      mainController.vehicleNameController.text =
                          "${car["brandName"]} ${car["model"]} " ?? " ";
                      mainController.seatsController.text = car["seating"] ?? " ";
                      mainController.rentalPricePerKmController.text =
                          car["pricePerDay"] ?? " ";
                      mainController.perKmController.text = car["distanceRange"] ?? " ";
                      mainController.distanceFromYouController.text = "2.5" ??  " ";
                      mainController.averageController.text = car["average"] ?? " ";
                      mainController.kpmlController.text = car["kmpl"] ?? " ";
                      mainController.typeController.text = car["type"] ?? " ";
                      mainController.ownerNameController.text = car["ownerName"] ?? " ";
                      mainController.ownerPhoneNumberController.text =
                          "9999223222";
                      mainController.vehicleNumberController.text =
                          car['vehicleNumber'] ?? " ";
                      mainController.base24PriceController.text = car['base_24'] ?? " ";
                      mainController.base12PriceController.text = car['base_12'] ?? " ";
                      mainController.pricePerHourCust.text =
                          car['pricePerHourCust'] ?? " ";
                      mainController.pricePerKmCust.text = car['pricePerKmCust'];

                      return VehicleTile(
                        imgUrl: mainController.imgUrlController.text,
                        vehicleName: mainController.vehicleNameController.text,
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
                        vehicleNumber:
                            mainController.vehicleNumberController.text,
                        ////
                        delivery: mainController.delivery.text, //widget.delivery,
                        source:
                            mainController.vehicleSource.text, //widget.source,
                        destination: mainController
                            .vehicleDestination.text, //widget.destination,
                        pickupDateTime: mainController
                            .pickupDateTime.text, //widget.pickupDateTime,
                        returnDateTime: mainController
                            .returnDateTime.text, //widget.returnDateTime,
                        purpose: mainController.purpose.text, //widget.purpose,
                        vehicleLocation: mainController
                            .vehicleNeedLocations.text, //widget.vehicleLocation,
                        userseats: mainController
                            .seatsDropDownController.selectedItem, //widget.seats,
                        pricePerKmCust: mainController.pricePerKmCust.text,
                        pricerPerHourCust: mainController.pricePerHourCust.text,
                        base_12: mainController.base12PriceController.text,
                        base_24: mainController.base24PriceController.text,
                      );
                    } catch (e) {
                      //
                      Fluttertoast.showToast(
                        msg: 'Error, try again.',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey[600],
                        textColor: Colors.black,
                        fontSize: 16.0,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
