import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:intl/intl.dart';


class TimeSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final int divisions;

  TimeSlider({this.minValue = 0.0, this.maxValue = 25.0, this.divisions = 12});

  @override
  State<TimeSlider> createState() => _TimeSliderState();
}

class _TimeSliderState extends State<TimeSlider> {
  String displayValue = '12';
  int totalDays = 0;

  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    final sliderController = Get.put(SliderController());
    MainController mainController = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   margin: EdgeInsets.only(left: 10.0, top: 10.0),
        //   child: Text(
        //     'Total Time: ${mainController.userChosenTime.text} ',
        //     style: TextStyle(
        //       fontSize: 12,
        //       color: Colors.grey,
        //     ),
        //   ),
        // ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            // Expanded(
            //   child: Obx(() => SizedBox(
            //     width: 265.0,
            //     child: Slider(
            //       value: sliderController.sliderValue.value,
            //       min: widget.minValue,
            //       max: widget.maxValue,
            //       divisions: widget.divisions,
            //       label: sliderController.sliderValue.value.round().toString(),
            //       onChanged: (newValue) {
            //         final step = (widget.maxValue - widget.minValue) / widget.divisions;
            //         sliderController.sliderValue.value = (newValue / step).roundToDouble() * step;
            //
            //         setState(() {
            //           if (sliderController.sliderValue.value >= 24) {
            //             sliderController.sliderValue.value = widget.minValue;
            //             totalDays++;
            //             print('Total Days: $totalDays');
            //           }
            //
            //           displayValue = sliderController.sliderValue.value.round().toString();
            //           mainController.userChoiceHoursController.text = displayValue;
            //           mainController.userChosenTime.text = '${totalDays.toString()} day(s) ${displayValue} hrs';
            //
            //           // Update mainController.returnDateTime with the chosen time
            //           mainController.returnDateTime.text = DateTime.now().add(Duration(days: totalDays, hours: int.parse(displayValue))).toString();
            //         });
            //       },
            //
            //     ),
            //   )),
            // ),
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

                    mainController.userChoiceHoursController.text = displayValue;
                    mainController.userChosenTime.text =
                    '${totalDays.toString()} day(s) ${displayValue} hrs';
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8, // Set the width based on the screen size
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    '$displayValue Hrs',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.blue),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.blue[100],
                  ),
                  height: 35.0,
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
