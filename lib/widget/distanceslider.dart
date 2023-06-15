import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DistanceSlider extends StatelessWidget {
  final double minValue;
  final double maxValue;
  final int divisions;

  DistanceSlider(
      {this.minValue = 50.0, this.maxValue = 100.0, this.divisions = 10});

  @override
  Widget build(BuildContext context) {
    final sliderController = Get.put(DistanceSliderController());

    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 10.0,
        ),
        Obx(() => Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                'Km Range, per day  ${sliderController.sliderValue.value.toStringAsFixed(1)} km',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
            )),
        Row(
          children: [
            Obx(
              () => SizedBox(
                width: 265.0,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 1,
                    thumbColor: Colors.transparent,
                    thumbShape: SliderComponentShape.noThumb,
                  ),
                  child: RangeSlider(
                    activeColor: Colors.blue,

                    // min: 0.0,
                    min: minValue,
                    max: maxValue,
                    values: RangeValues(sliderController.startval.value,
                        sliderController.endval.value),

                    divisions: divisions,
                    onChanged: (newValue) {
                      sliderController.startval.value = newValue.start;
                      sliderController.endval.value = newValue.end;

                      // sliderController.sliderValue.value = newValue;
                    },
                  ),
                ),
              ),
            ),
            Obx(
              () => Container(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  '${sliderController.startval.toStringAsFixed(1)} - ${sliderController.endval.toStringAsFixed(1)} km',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
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
  var startval = 50.0.obs;
  var endval = 90.0.obs;
}
