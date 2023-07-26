import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/screens/chooseVehicle.dart';

class KycPopUp extends StatefulWidget {
  const KycPopUp({
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
  final RxString seats;
  final String vehicleLocation;
  final String source;
  final String destination;
  final String pickupDateTime;
  final String returnDateTime;
  final String delivery;
  final String purpose;
  @override
  State<KycPopUp> createState() => _KycPopUpState();
}

class _KycPopUpState extends State<KycPopUp> {

  MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Icon(
            Icons.check_circle,
            size: 60.0,
            color: Colors.green[400],
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Center(
            child: Text(
              'Successfully Uploaded!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
              margin: const EdgeInsets.all(4.0),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'You have uploaded all documents successfully.\n'
                  'Verification will be done by Rush wheels within short time.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          GestureDetector(
            onTap: () {
              Get.offAll(ChooseVehicle(vehicleType:  mainController.vehicleTypeController.text,));
              // Get.offAll(Home());
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                color: Colors.green[400],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Center(
                child: Text(
                  'ok',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
