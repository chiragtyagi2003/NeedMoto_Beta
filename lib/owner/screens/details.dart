import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_main_controller.dart';
import '../object/dropDownButtons/companyDrop.dart';
import '../object/textField.dart';

// Screen for new vehicle details
class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  int _challansValue = 0;
  int _insuranceValue = 0;
  bool checkfield = false;

  // Access the OwnerMainController instance
  OwnerMainController mainController = Get.find();

  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          TextInputField(
            controller: mainController.vehicleNameController,
            myLabelText: "Vehicle Name",
          ),
          const SizedBox(height: 20),
          DropField(), // Custom dropdown field for company selection
          const SizedBox(height: 20),
          TextInputField(
            controller: mainController.vehicleNumberController,
            myLabelText: "Number",
          ),
          const SizedBox(height: 20),
          TextInputField(
            controller: mainController.vehicleModelController,
            myLabelText: "Model",
          ),
          const SizedBox(height: 20),
          TextInputField(
            controller: mainController.vehicleCurrentReadingController,
            myLabelText: "Current Reading",
          ),
          const SizedBox(height: 20),
          TextInputField(
            controller: mainController.vehicleRcNumberController,
            myLabelText: "RC Number",
          ),
          challansInsurance(), // Widget for displaying challans and insurance options
          TextInputField(
            controller: mainController.vehicleLocationController,
            myLabelText: "Vehicle Location",
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.47, top: 2),
            child: const Text(
              "Same as home address",
              style: TextStyle(color: Colors.red),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Widget for displaying challans and insurance radio options
  Widget challansInsurance() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text(
                "Pending Challans",
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _challansValue,
                        onChanged: (value) {
                          setState(() {
                            mainController.vehiclePendingChallansController =
                            value! as TextEditingController;
                            _challansValue = value;
                          });
                        },
                      ),
                      const Text("Yes"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _challansValue,
                        onChanged: (value) {
                          setState(() {
                            _challansValue = value!;
                          });
                        },
                      ),
                      const Text("No"),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                "Have Insurance for Vehicle",
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _insuranceValue,
                        onChanged: (value) {
                          setState(() {
                            mainController.vehicleInsuranceController =
                            value! as TextEditingController;
                            _insuranceValue = value;
                          });
                        },
                      ),
                      const Text("Yes"),
                    ],
                  ),
                  const SizedBox(width: 2),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _insuranceValue,
                        onChanged: (value) {
                          setState(() {
                            _insuranceValue = value!;
                          });
                        },
                      ),
                      const Text("No"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
