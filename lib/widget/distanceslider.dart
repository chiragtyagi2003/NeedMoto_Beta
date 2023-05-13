import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class DistanceSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final int divisions;

  DistanceSlider({this.minValue = 50.0, this.maxValue = 1000.0, this.divisions = 100});

  @override
  State<DistanceSlider> createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<DistanceSlider> {
  double initialValue = 0.0;
  double minValue = 150.0;

  MainController mainController = Get.find();

  final sliderController = Get.put(DistanceSliderController());

  @override
  void initState() {
    super.initState();
    setMinValue();
    sliderController.sliderValue.value = minValue;
    mainController.userChoiceHoursController.addListener(setMinValue);
  }

  @override
  void dispose() {
    mainController.userChoiceHoursController.removeListener(setMinValue);
    super.dispose();
  }

  void setMinValue() {
    minValue = mainController.userChoiceHoursController.text == '12' ? 150.0 : widget.minValue;
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 10.0,),
        Obx(() => Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Text(
            'Km Range, per day  ${sliderController.sliderValue.value.toStringAsFixed(1)} km',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        )),
        Row(
          children: [
            Expanded(
              child: Obx(() => SizedBox(
                width: 265.0,
                child: Slider(
                  value: sliderController.sliderValue.value,
                  min: minValue,
                  max: widget.maxValue,
                  divisions: widget.divisions,
                  label: sliderController.sliderValue.value.toStringAsFixed(1),
                  onChanged: (newValue) {
                    sliderController.sliderValue.value = newValue;
                    mainController.distanceController.text = newValue.toString();
                    //print(mainController.distanceController.text);
                  },
                ),
              ),
          ),
            ),

            Obx(() =>
                Container
                  (
                  padding: EdgeInsets.all(10.0),
                  child: Text('${sliderController.sliderValue.value.toStringAsFixed(1)} km'),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.blue),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.blue[100],
                  ),

                ),
            ),
          ],
        ),

      ],
    );
  }
}

class DistanceSliderController extends GetxController {
  var sliderValue = 50.0.obs;
}
