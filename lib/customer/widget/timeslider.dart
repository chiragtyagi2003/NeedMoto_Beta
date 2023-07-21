import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';

class TimeSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final int divisions;

  const TimeSlider({super.key, this.minValue = 0.0, this.maxValue = 25.0, this.divisions = 12});

  @override
  State<TimeSlider> createState() => _TimeSliderState();
}

class _TimeSliderState extends State<TimeSlider> {
  String displayValue = '12';
  int totalDays = 0;

  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (displayValue == '12') {
                      displayValue = '24';
                      mainController.displayValue = '24';
                    } else {
                      displayValue = '12';
                      mainController.displayValue = '12';
                    }

                    mainController.userChoiceHoursController.text =
                        displayValue;
                    mainController.userChosenTime.text =
                        '${totalDays.toString()} day(s) $displayValue hrs';
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.8, // Set the width based on the screen size
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.blue),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.blue[100],
                  ),
                  height: 35.0,
                  child: Text(
                    '$displayValue Hrs',
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SliderController extends GetxController {
  var sliderValue = 12.0.obs;
}
