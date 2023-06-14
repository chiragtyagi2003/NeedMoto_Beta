// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class DateController extends GetxController {
//   var selectedDate = DateTime.now().obs;
//   final textEditingController = TextEditingController();
//   final textEditingController2 = TextEditingController();

//   void chooseDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate.value,
//       firstDate: DateTime(2023),
//       lastDate: DateTime(2024),
//       helpText: 'Pickup Date',
//     );
//     if (pickedDate != null && pickedDate != selectedDate.value) {
//       selectedDate.value = pickedDate;
//       textEditingController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
//     }
//   }

//   void selectDate(BuildContext context) async {
//     final DateTime? pickDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate.value,
//       firstDate: DateTime(2023),
//       lastDate: DateTime(2024),
//       helpText: 'Return Date',
//     );
//     if (pickDate != null && pickDate != selectedDate.value) {
//       selectedDate.value = pickDate;
//       textEditingController2.text = DateFormat('dd-MM-yyyy').format(pickDate);
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeController extends GetxController {
  Rx<DateTime> selectedDateTime = Rx<DateTime>(DateTime.now());

  Future<DateTime?> selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDateTime.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                Colors.blue, // Customize the color of the date picker header
            hintColor:
                Colors.blue, // Customize the color of the selected date
            colorScheme: ColorScheme.light(
                primary: Colors.blue), // Customize the calendar color
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime.value),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor:
                  Colors.blue, // Customize the color of the time picker header
              hintColor:
                  Colors.blue, // Customize the color of the selected time
              colorScheme: ColorScheme.light(
                  primary: Colors.blue), // Customize the dial color
              buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        selectedDateTime.value = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }

      return selectedDateTime.value;
      print("pickedDateTime: $selectedDateTime.value");
    }
  }
}
