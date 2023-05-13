import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainController extends GetxController {
  TextEditingController imgUrlController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController averageController = TextEditingController();
  TextEditingController kpmlController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerPhoneNumberController = TextEditingController();
  TextEditingController rentalPricePerKmController = TextEditingController();
  TextEditingController perKmController = TextEditingController();
  TextEditingController distanceFromYouController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController modelNameController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController distanceRangeController = TextEditingController();
  TextEditingController rentalPricePerDayController = TextEditingController();
  TextEditingController requestStatusController = TextEditingController(text: 'accepted');
  TextEditingController payPriceController = TextEditingController();
  TextEditingController base12PriceController = TextEditingController();
  TextEditingController base24PriceController = TextEditingController();
  TextEditingController pricePerKmCust = TextEditingController();
  TextEditingController pricePerHourCust = TextEditingController();
  TextEditingController userChoiceHoursController = TextEditingController(text: '12');
  TextEditingController distanceController = TextEditingController(text: '150');
  TextEditingController extraHoursController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();
}
