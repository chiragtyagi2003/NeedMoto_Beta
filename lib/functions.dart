import 'package:flutter/cupertino.dart';
import 'package:need_moto/controllers/main_controller.dart';
import 'package:get/get.dart';

class CarRentalPrice {

  MainController mainController = Get.find();

  void calculateRentalPrice(double base_12, double base_24, double pricePerHourCust, double pricePerKmCust) {

    double basePrice;
    double distanceLimit;
    double numberOfExtraHours = double.parse(mainController.extraHoursController.text);
    double distance = double.parse(mainController.distanceController.text);


    // Set base price and distance limit based on conditions
    if (mainController.userChoiceHoursController.value == 12) {
      basePrice = base_12;
    } else {
      basePrice = base_24;
    }

    if (mainController.userChoiceHoursController.value == 12) {
      distanceLimit = 150.0;
    } else {
      distanceLimit = 350.0;
    }

    double extraHoursCost = numberOfExtraHours * pricePerHourCust;
    double distanceCost = (distance - distanceLimit) * pricePerKmCust;

    double totalCost = basePrice + extraHoursCost + distanceCost;
    print(totalCost);
    mainController.totalPriceController.text = totalCost.toString();
  }
}
