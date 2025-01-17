import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/widget/form.dart';
import '../controllers/VehicleBookingController.dart';

class UserChoiceSeats extends StatefulWidget {
  const UserChoiceSeats({super.key});

  @override
  State<UserChoiceSeats> createState() => _UserChoiceSeatsState();
}

class _UserChoiceSeatsState extends State<UserChoiceSeats> {
  final userChoiceController = Get.put(UserChoiceController());

  bool isSelected = false;
  bool isAnimated = false;
  bool isAnimatedback = true;
  bool isEditable = false;

  MainController mainController = Get.find();

  // Define a callback function to pass to each UserChoiceButton
  void handleButtonTap(String label) {
    final vehicleBookingController = Get.find<VehicleBookingController>();
    vehicleBookingController.filterCars(label);
    userChoiceController.selectedButton.value = label;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Obx(() => Row(
                children: [
                  // SizedBox(width: 16), // Add some padding to the left
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        UserChoiceButton(
                          icon: Icons.event_seat_sharp,
                          label: '4',
                          isSelected:
                              userChoiceController.selectedButton.value == '4',
                          onTap: handleButtonTap,
                        ),
                        UserChoiceButton(
                          icon: Icons.event_seat_sharp,
                          label: '5',
                          isSelected:
                              userChoiceController.selectedButton.value == '5',
                          onTap: handleButtonTap,
                        ),
                        UserChoiceButton(
                          icon: Icons.event_seat_sharp,
                          label: '6+',
                          isSelected:
                              userChoiceController.selectedButton.value == '6',
                          onTap: handleButtonTap,
                        ),
                        // UserChoiceButton(
                        //   icon: Icons.directions_car,
                        //   label: 'Jeeps',
                        //   isSelected:
                        //       userChoiceController.selectedButton.value ==
                        //           '1',
                        //   onTap: handleButtonTap,
                        // ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (isEditable == false) {
                              isEditable = true;
                            } else {
                              isEditable = false;
                            }
                          });
                        },
                        child: Container(
                          color: Colors.green[100],
                          width: 50.0,
                          height: 23.0,
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (isAnimated == false) {
                              isAnimated = true;
                            } else {
                              isAnimated = false;
                            }
                          });
                        },
                        child: Container(
                          color: Colors.green[100],
                          width: 50.0,
                          height: 20.0,
                          child: isAnimated
                              ? const Icon(Icons.arrow_drop_up)
                              : const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                    ],
                  ),
                  //SizedBox(width: 16), // Add some padding to the right
                ],
              )),
        ),
        const SizedBox(height: 10),
        const Divider(
          height: 1,
          color: Colors.black54,
        ),
        isAnimated
            ? FormTile(
                isEditable: isEditable,
              )
            : Container(),
      ],
    );
  }
}

class UserChoiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Function(String) onTap;

  final VehicleBookingController vehicleBookingController = Get.find();

  UserChoiceButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () {
          if (label == 'Jeeps') {
            // Pass a 1 for Jeeps
            onTap("-1");
          } else if (label == "6+") {
            onTap("6");
          } else {
            onTap(label); // Parse the label string to an int
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: 15,
          width: 80,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      icon,
                      color: isSelected ? Colors.white : Colors.black,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserChoiceController extends GetxController {
  final selectedButton = '4'.obs;
}

class UserFormController extends GetxController {
  final containerVisible = false.obs;

  void toggleContainer() {
    containerVisible.value = !containerVisible.value;
  }
}
