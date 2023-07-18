// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class RazorpayService {
//   late Razorpay _razorpay;
//
//   void initializeRazorpay() {
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   void openCheckout(int amount) {
//     var options = {
//       'key': 'rzp_test_ZZVNGOinkqnpOD',
//       'amount': amount * 100, // Convert amount to paise
//       'name': 'Test Payment',
//       'description': 'Test payment description',
//       'prefill': {'contact': 'YOUR_CONTACT_NUMBER', 'email': 'YOUR_EMAIL'},
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error: ${e.toString()}');
//     }
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // Handle payment success here
//     Get.snackbar('Payment Successful', 'Payment ID: ${response.paymentId}');
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Handle payment failure here
//     Get.snackbar('Payment Failed', 'Code: ${response.code}, Message: ${response.message}');
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Handle external wallet payments (if supported)
//     Get.snackbar('External Wallet', 'Wallet Name: ${response.walletName}');
//   }
// }
