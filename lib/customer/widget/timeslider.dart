import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';


class TimeSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final int divisions;

  TimeSlider({this.minValue = 12.0, this.maxValue = 24.0, this.divisions = 12});

  @override
  State<TimeSlider> createState() => _TimeSliderState();
}

class _TimeSliderState extends State<TimeSlider> {
  String displayValue = '12'; // Declare the displayValue variable
  @override
  Widget build(BuildContext context) {
    final sliderController = Get.put(SliderController());


    MainController mainController = Get.find();

    return Column(
     // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() =>
            Container(
          margin: EdgeInsets.only(left: 10.0,top: 10.0),
          child: Text(
            'Hours and Days ${sliderController.sliderValue.value.toStringAsFixed(1)} Hrs',
            style: TextStyle(
                fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
        ),
        Row(
          children: [
            Obx(() => SizedBox(
              width: 240.0,
              child: Slider(
                value: sliderController.sliderValue.value,
                min: widget.minValue,
                max: widget.maxValue,
                divisions: widget.divisions,
                label: sliderController.sliderValue.value.round().toString(),
                onChanged: (newValue) {
                  final step = (widget.maxValue - widget.minValue) / widget.divisions;
                  sliderController.sliderValue.value =
                      (newValue / step).roundToDouble() * step;

                  mainController.extraHoursController.text = sliderController.sliderValue.value.toString();

                },
              ),
            ),
            ),

            // Obx(() =>
            //     Container
            //       (
            //       padding: EdgeInsets.all(5.0),
            //       child: Text(
            //           '${sliderController.sliderValue.value.toStringAsFixed(1)} Hrs',
            //         style: TextStyle(
            //           fontSize: 10.0,
            //         ),
            //       ),
            //       decoration: BoxDecoration(
            //         border: Border.all(width: 1.0, color: Colors.blue),
            //         borderRadius: BorderRadius.circular(5.0),
            //         color: Colors.blue[100],
            //       ),
            //       width: 50.0,
            //
            //     ),
            // ),

            GestureDetector(
              onTap: () {
                print('tapped');
                setState(() {
                  if (displayValue == '12') {
                    displayValue = '24';
                  } else {
                    displayValue = '12';
                  }

                  mainController.userChoiceHoursController.text = displayValue;
                  print(double.parse(mainController.userChoiceHoursController.text));
                });
              },
              child: Container(
                padding: EdgeInsets.all(5.0),
                  child: Text(
                    '$displayValue Hrs',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.blue),
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.blue[100],
                ),
                width: 50.0,
                height: 25.0,
              ),
            ),

            SizedBox(width: 5.0,),
            //Obx(() =>
                Container
                  (
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                      '1 Day',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.blue),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.blue[100],
                  ),
                  width: 45.0,

                ),
            //),
          ],
        ),
      ],
    );
  }
}

class SliderController extends GetxController {
  var sliderValue = 12.0.obs;
}
