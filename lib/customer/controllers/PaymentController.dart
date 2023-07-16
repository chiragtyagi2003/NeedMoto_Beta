
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/RazorpayService.dart';

class PaymentController extends GetxController {
  late RazorpayService _razorpayService;
  RxInt amount = 0.obs; // Use RxInt to make it reactive

  @override
  void onInit() {
    super.onInit();
    _razorpayService = RazorpayService();
    _razorpayService.initializeRazorpay();
  }

  void makePayment() {
    _razorpayService.openCheckout(amount.value);
  }
}