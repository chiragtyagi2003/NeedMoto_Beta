import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_file_controller.dart';
import 'package:need_moto/owner/controller/owner_image_controller.dart';
import 'package:need_moto/owner/controller/owner_main_controller.dart';
import 'package:need_moto/owner/screens/details.dart';
import 'package:need_moto/owner/screens/ownerHome.dart';
import 'package:need_moto/owner/screens/ownerPhotosUpload.dart';
import 'package:need_moto/owner/screens/ownerFileUpload.dart';

// Screen flow for adding a new vehicle
class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  int _currentStep = 0;
  bool checkField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "VEHICLE DETAILS",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              controlsBuilder: (context, controller) {
                return const SizedBox.shrink();
              },
              elevation: 0,
              type: StepperType.horizontal,
              physics: const ScrollPhysics(),
              currentStep: _currentStep,
              onStepTapped: (step) => tapped(step),
              steps: <Step>[
                Step(
                  title: const Text('Details'),
                  content: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: const DetailsPage(),
                      ),
                      nextButton(0),
                    ],
                  ),
                  isActive: _currentStep > 0,
                  state:
                  _currentStep > 0 ? StepState.complete : StepState.editing,
                ),
                Step(
                  title: const Text('Documents'),
                  content: Column(
                    children: [
                      // Show the appropriate document upload widget
                      const OwnerFileUpload(),
                      nextButton(1),
                    ],
                  ),
                  isActive: _currentStep > 1,
                  state:
                  _currentStep > 1 ? StepState.complete : StepState.editing,
                ),
                Step(
                  title: const Text('Photos'),
                  content: Column(
                    children: <Widget>[
                      const UploadPhotos(),
                      const SizedBox(height: 40),
                      nextButton(2),
                    ],
                  ),
                  isActive: _currentStep > 2,
                  state:
                  _currentStep > 2 ? StepState.complete : StepState.editing,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget for displaying the next button
  Widget nextButton(int currentStep) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            height: 55,
            child: _currentStep == 2
                ? ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 15, 94, 159),
                ),
              ),
              onPressed: () async {
                // Save the vehicle data to the database
                await Get.find<OwnerMainController>()
                    .saveVehicleDataToFirestore();

                // Save the files to the database
                await Get.find<OwnerFileController>().uploadFiles();

                // Save the images to the database
                await Get.find<OwnerImageController>()
                    .uploadImagesToFirebase();

                Get.defaultDialog(
                  title: "Submit Successfully",
                  middleText:
                  "You have uploaded all documents successfully. Verification will be done by Rush wheels within 24 hours.",
                  confirm: ElevatedButton(
                    onPressed: () {
                      Get.to(const OwnerHome());
                    },
                    child: const Text('Ok'),
                  ),
                );
              },
              child: const Center(
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
                : ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 15, 94, 159),
                ),
              ),
              onPressed: () {
                _currentStep < 2
                    ? setState(() => _currentStep += 1)
                    : null;
              },
              child: const Center(
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          _currentStep > 0
              ? InkWell(
            onTap: () {
              _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
            },
            child: Container(
              margin: const EdgeInsets.only(left: 30),
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 0.2,
              height: 50,
              child: const Text(
                "Prev",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          )
              : const SizedBox(
            width: 0,
            height: 10.0,
          ),
        ],
      ),
    );
  }

  // Callback function for handling step tapping
  tapped(int step) {
    setState(() => _currentStep = step);
  }
}

