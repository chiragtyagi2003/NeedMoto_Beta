import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/dropdown_controller.dart';
import 'package:need_moto/owner/controller/owner_main_controller.dart';
import '../object/dropDownButtons/companydrop.dart';
import '../object/textfield.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  int _challansValue = 0;

  int _insurenceValue = 0;

  bool checkfield = false;

  OwnerMainController mainController = Get.find();

  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    DropdownController controller = DropdownController();


    String? _currentSugars;

    return Column(children: [
      TextInputField(
          controller: mainController.vehicleNameController, myLabelText: "Vehicle Name"),
      const SizedBox(height: 20),
      //
      DropField(),
      //
      const SizedBox(height: 20),
      //
      TextInputField(controller: mainController.vehicleNumberController, myLabelText: "Number"),
      //
      const SizedBox(height: 20),
      //
      TextInputField(controller: mainController.vehicleModelController, myLabelText: "Model"),
      //
      const SizedBox(height: 20),
      //
      TextInputField(
          controller: mainController.vehicleCurrentReadingController,
          myLabelText: "Current Reading"),
      const SizedBox(height: 20),
      //
      TextInputField(controller: mainController.vehicleRcNumberController, myLabelText: "RC Number"),
      //
      // const SizedBox(height: 20),
      // //
      // FuelDropField(),
      // //
      // const SizedBox(height: 20),
      // OwnTaxDropField(),
      // //
      // const SizedBox(height: 10),
      //
      _Challans_Insurence(),
      SizedBox(height: 10),
      TextInputField(
          controller: mainController.vehicleLocationController, myLabelText: "Vehicle Location"),
      const Padding(
        padding: const EdgeInsets.only(left: 170, top: 2),
        child: Text(
          "Same as home address",
          style: TextStyle(color: Colors.red),
        ),
      ),
      SizedBox(height: 20),
      // ElevatedButton(
      //   style: ButtonStyle(
      //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //         RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(40),
      //     )),
      //     backgroundColor:
      //         MaterialStateProperty.all(Color.fromARGB(255, 15, 94, 159)),
      //   ),
      //   onPressed: () {
      //     // VehicleDetailsController.instance.details(
      //     //   _vehicalnameController.text,
      //     //   controller.selectedVal.toString(),
      //     //   _numberController.text,
      //     //   _modelController.text,
      //     //   _currentReadingController.text,
      //     //   _rcNumberController.text,
      //     //   _vehicleLocation.text,
      //     // );
      //     // Navigator.push(context,
      //     //     MaterialPageRoute(builder: (context) => OwnFileUpload()));
      //   },
      //   child: Center(
      //     child: Text(
      //       "Next",
      //       style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      // ),
    ]);
  }

  Widget _Challans_Insurence() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            Text(
              "Pending Challans",
              style: TextStyle(color: Colors.black54),
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
                            mainController.vehiclePendingChallansController = value! as TextEditingController;
                            _challansValue = value!;
                          });
                        }),
                    Text(
                      "Yes",
                    ),
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
                        }),
                    Text(
                      "No",
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Have Insurence for Vehicle",
              style: TextStyle(color: Colors.black54),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                        value: 1,
                        groupValue: _insurenceValue,
                        onChanged: (value) {
                          setState(() {
                            mainController.vehicleInsuranceController =  value! as TextEditingController;
                            _insurenceValue = value!;
                          });
                        }),
                    Text("Yes"),
                  ],
                ),
                SizedBox(width: 30),
                Row(
                  children: [
                    Radio(
                        value: 2,
                        groupValue: _insurenceValue,
                        onChanged: (value) {
                          setState(() {
                            _insurenceValue = value!;
                          });
                        }),
                    Text("No"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
