import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSlider extends StatelessWidget {
  final double minValue;
  final double maxValue;
  final int divisions;

  TimeSlider({this.minValue = 12.0, this.maxValue = 24.0, this.divisions = 12});

  @override
  Widget build(BuildContext context) {
    final sliderController = Get.put(SliderController());

    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Obx(() =>
        Container(
          margin: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(
            'Hours and Days',
            style: TextStyle(
                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
          ),
        ),
        //),
        Row(
          children: [
            Obx(
              () => SizedBox(
                width: 240.0,
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
                      sliderController.disp.value =
                          (newValue.end - newValue.start);
                      sliderController.flag.value =
                          (((newValue.end - newValue.start) / 24) + 1).floor() >
                                  1
                              ? true
                              : false;

                      // sliderController.sliderValue.value = newValue;
                    },
                  ),
                ),
                // child: Slider(
                //   value: sliderController.sliderValue.value,
                //   min: minValue,
                //   max: maxValue,
                //   divisions: divisions,
                //   label: sliderController.sliderValue.value.round().toString(),
                //   onChanged: (newValue) {
                //     final step = (maxValue - minValue) / divisions;
                //     sliderController.sliderValue.value =
                //         (newValue / step).roundToDouble() * step;
                //   },
                // ),
              ),
            ),

            Obx(
              () => Container(
                padding: EdgeInsets.all(6.5),
                child: Text(
                  '${sliderController.endval.toStringAsFixed(1)} Hrs',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600),
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.blue),
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.blue[100],
                ),
                width: 80.0,
              ),
            ),

            SizedBox(
              width: 5.0,
            ),
            //Obx(() =>
            Container(
              padding: EdgeInsets.all(7.0),
              child: Text(
                sliderController.flag.value
                    ? '${(sliderController.disp.value / 24).floor() + 1} days'
                    : '${(sliderController.disp.value / 24).floor() + 1} day',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.blue),
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.blue[100],
              ),
              width: 60.0,
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
  var startval = 12.0.obs;
  var endval = 24.0.obs;
  var disp = 12.0.obs;
  var flag = false.obs;
}
