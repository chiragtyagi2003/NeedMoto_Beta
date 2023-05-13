import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class DateController extends GetxController {
  var selectedDate = DateTime.now().obs;
  final textEditingController = TextEditingController();
  final textEditingController2 = TextEditingController();

  void chooseDate(BuildContext context) async{
   final DateTime? pickedDate=await
    showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2023),
        lastDate: DateTime(2024),
        helpText: 'Pickup Date',
    );
    if(pickedDate!=null && pickedDate!=selectedDate.value){
      selectedDate.value=pickedDate;
      textEditingController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    }
  }

  void selectDate(BuildContext context) async{
    final DateTime? pickDate=await
    showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2023),
        lastDate: DateTime(2024),
      helpText: 'Return Date',
    );
    if(pickDate!=null && pickDate!=selectedDate.value){
      selectedDate.value=pickDate;
      textEditingController2.text = DateFormat('dd-MM-yyyy').format(pickDate);
    }
  }
}

