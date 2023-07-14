import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:need_moto/admin/controllers/admin_booking_controller.dart';
import 'package:need_moto/admin/controllers/admin_request_controller.dart';
import 'package:need_moto/admin/controllers/payment_controller.dart';
import 'package:need_moto/customer/controllers/PaymentController.dart';
import 'package:need_moto/customer/controllers/Request_Controller.dart';
import 'package:need_moto/customer/controllers/VehicleBookingController.dart';
import 'package:need_moto/customer/controllers/booking_controller.dart';
import 'package:need_moto/customer/controllers/controllerkyc.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/controllers/user_controllers.dart';
import 'package:need_moto/customer/controllers/vehicleSubmitController.dart';
import 'package:need_moto/customer/screens/Grid.dart';
import 'package:need_moto/customer/screens/Home.dart';
import 'package:need_moto/customer/screens/RequestAccepted.dart';
import 'package:need_moto/customer/screens/StartingPage.dart';
import 'package:need_moto/owner/controller/owner_auth_controller.dart';
import 'package:need_moto/owner/controller/owner_image_controller.dart';
import 'package:need_moto/owner/controller/owner_main_controller.dart';
import 'package:need_moto/owner/controller/owner_request_handler.dart';
import 'package:need_moto/owner/controller/vehicle_details_controller.dart';


void main() async {

  // initialize the firebase services for the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // put get controllers for state management

  // customer controllers
  Get.put(KycController());
  Get.put(MainController());
  Get.put(UserController());
  Get.put(PaymentController());
  Get.put(RequestController());
  Get.put(VehicleBookingController());
  Get.put(BookingController());
  Get.put(VehicleSubmitController());

  // owner controllers
  Get.put(OwnerMainController());
  Get.put(OwnerAuthController());
  Get.put(VehicleDetailsController());
  Get.put(OwnerImageController());
  Get.put(OwnerRequestHandler());


  // admin controllers
  Get.put(AdminPaymentsController());
  Get.put(AdminBookingController());
  Get.put(AdminRequestController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
        fontFamily: 'NotoSans',
        primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/home', page: () => Home()),
          GetPage(name: '/StartPage', page: () => AnimatedCardsListView()),
          GetPage(name: '/grid', page: () => Grid()),

          // testing routes
          GetPage(name: '/reqAcc', page: () => RequestAccepted(source: 'delhi',
              destination: 'lucknow',
              pickupDateTime: '22-02-22 14:28',
              returnDateTime: '23-01-23 11:34',
              delivery: 'Home Delivery',
              purpose: 'Travel',
              ownerName: 'Chirag Tyagi',
              ownerPhoneNumber: 'ccccc',
              type: 'diesel',
              vehicleNumber: 'TD22DG3323',
              vehicleName: 'Merc Benz',
              seats: '4',
              rentalPrice: 3234.53,
              base_12: '4000',
              base_24: '5000',
          )),
        ]);
  }
}

