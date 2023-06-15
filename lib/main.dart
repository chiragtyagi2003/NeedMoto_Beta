import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:need_moto/customer/controllers/PaymentController.dart';
import 'package:need_moto/customer/controllers/Request_Controller.dart';
import 'package:need_moto/customer/controllers/VehicleBookingController.dart';
import 'package:need_moto/customer/controllers/booking_controller.dart';
import 'package:need_moto/customer/controllers/controllerkyc.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/controllers/user_controllers.dart';
import 'package:need_moto/customer/screens/Home.dart';
import 'package:need_moto/customer/screens/StartingPage.dart';
import 'package:need_moto/customer/screens/screenshot.dart';


void main() async {

  // initialize the firebase services for the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // put get controllers for state management
  Get.put(KycController());
  Get.put(MyHomePageController());
  Get.put(MainController());
  Get.put(UserController());
  Get.put(PaymentController());
  Get.put(RequestController());
  Get.put(VehicleBookingController());
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
        initialRoute: '/StartPage',
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/home', page: () => Home()),
          GetPage(name: '/StartPage', page: () => AnimatedCardsListView())
        ]);
  }
}

