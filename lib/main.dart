import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:need_moto/controllers/VehicleBookingController.dart';
import 'package:need_moto/controllers/controllerkyc.dart';
import 'package:need_moto/controllers/filecontroller.dart';
import 'package:need_moto/controllers/main_controller.dart';
import 'package:need_moto/controllers/menucontroller.dart';
import 'package:need_moto/mywidget.dart';
import 'package:need_moto/screens/admin_dashboard.dart';
import 'package:need_moto/screens/seventh.dart';
import 'package:need_moto/screens/sixth.dart';
import 'package:get/get.dart';
import 'package:need_moto/screens/tenth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as auth_ui;
import 'package:need_moto/screens/Home.dart';

import 'controllers/booking_controller.dart';
import 'widget/car.dart';
import 'widget/request.dart';

void main() async {
  //making the menu controller available
  //throughout the app
  //Get.put(MenuController())
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(BookingColntroller());
  Get.put(KycController());
  Get.put(MainController());
  Get.put(FileController('qFm8nd1BODSFfJLEsGNFLzjbOiN2'));
  Get.put(VehicleBookingController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool isAdmin(User? user) {
    // Check if the user's email address matches the admin email
    String adminEmail = 'tyagichirag2025@gmail.com'; // Replace with your admin email
    return user != null && user.email == adminEmail;
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: '/signInScreen',
        debugShowCheckedModeBanner: false,
        getPages: [
          // GetPage(name: '/sixth', page: () => sixth()),
          GetPage(name: '/home', page: () => Home()),
          GetPage(name: '/seventh', page: () => seventh()),
          GetPage(name: '/adminDashboard', page: () => AdminDashboard()),
          GetPage(
            name: '/signInScreen',
            page: () => auth_ui.SignInScreen(
            providers: [
            auth_ui.EmailAuthProvider(),
            ],
            actions: [
              auth_ui.AuthStateChangeAction<auth_ui.SignedIn>((context, state) {
                // Check if the signed-in user is an admin
                if (isAdmin(state.user)) {
                  Get.offNamed('/adminDashboard'); // Redirect to the admin dashboard
                } else {
                  Get.offNamed('/home'); // Redirect to the regular user home page
                }
              }),
              auth_ui.AuthStateChangeAction<auth_ui.UserCreated>((context, state) {
                 // Redirect to the regular user home page after user creation
                 Get.offNamed('/home');
              }),
            ],
         ),
    ),

    // GetPage(
          //     name: '/signInScreen',
          //     page: () => SignInScreen(
          //           providers: [
          //             EmailAuthProvider(),
          //           ],
          //           actions: [
          //             AuthStateChangeAction<SignedIn>((context, state) {
          //               //Navigator.pushReplacementNamed(context, '/tenth');
          //               Get.offNamed('/home');
          //             }),
          //             AuthStateChangeAction<UserCreated>((context, state) {
          //               //Navigator.pushReplacementNamed(context, '/tenth');
          //               Get.offNamed('/home');
          //             }),
          //           ],
          //         ))

        ]);
  }
}
