import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';

class DistanceSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final int divisions;

  const DistanceSlider(
      {super.key,
      this.minValue = 150.0,
      this.maxValue = 1000.0,
      this.divisions = 100});

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


  void setMinValue() {
    double totalHours = double.parse(mainController.calculateDuration(mainController.pickupDateTime.text, mainController.returnDateTime.text));
    sliderController.sliderValue.value = totalHours > 23.0 ? 350.0 : 150.0;
    minValue = sliderController.sliderValue.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10.0,
        ),
        Obx(() => Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Km Range, per day  ${sliderController.sliderValue.value.toStringAsFixed(1)} km',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            )),
        Row(
          children: [
            Expanded(
              child: Obx(
                () => SizedBox(
                  width: 265.0,
                  child: Slider(
                    value: sliderController.sliderValue.value,
                    min: minValue,
                    max: widget.maxValue,
                    divisions: widget.divisions,
                    label:
                        sliderController.sliderValue.value.toStringAsFixed(1),
                    onChanged: (newValue) {
                      sliderController.sliderValue.value = newValue;
                      mainController.distanceController.text = newValue.toString();
                      // print(mainController.distanceController.text);
                    },
                  ),
                ),
              ),
            ),
            Obx(
              () => Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.blue),
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.blue[100],
                ),
                child: Text(
                    '${sliderController.sliderValue.value.toStringAsFixed(1)} km'),
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
