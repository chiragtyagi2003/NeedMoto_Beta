
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:need_moto/controllers/PaymentController.dart';
import 'package:need_moto/controllers/VehicleBookingController.dart';
import 'package:need_moto/controllers/controllerkyc.dart';
import 'package:need_moto/controllers/filecontroller.dart';
import 'package:need_moto/controllers/main_controller.dart';
import 'package:need_moto/controllers/menucontroller.dart';
import 'package:need_moto/controllers/user_controllers.dart';
import 'package:need_moto/mywidget.dart';
import 'package:need_moto/screens/StartingPage.dart';
import 'package:need_moto/screens/admin_dashboard.dart';
import 'package:need_moto/screens/screenshot.dart';
import 'package:need_moto/screens/seventh.dart';
import 'package:need_moto/screens/sixth.dart';
import 'package:get/get.dart';
import 'package:need_moto/screens/userkyc.dart';
import 'package:firebase_core/firebase_core.dart';
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
  Get.put(MyHomePageController());
  Get.put(MainController());
  Get.put(UserController());
  Get.put(PaymentController());
  //Get.put(FileController('qFm8nd1BODSFfJLEsGNFLzjbOiN2'));
  Get.put(VehicleBookingController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        // initialRoute: '/signInScreen',
        theme: ThemeData(
        fontFamily: 'NotoSans',
        primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/home', page: () => Home()),
          GetPage(name: '/seventh', page: () => seventh()),
          GetPage(name: '/adminDashboard', page: () => AdminDashboard()),
          GetPage(name: '/ss', page: () => MyHomePageView()),
          GetPage(
              // name: '/signInScreen',
              // page: () => SignInScreen(
              //       providers: [
              //         EmailAuthProvider(),
              //       ],
              //       actions: [
              //         AuthStateChangeAction<SignedIn>((context, state) {
              //           //Navigator.pushReplacementNamed(context, '/tenth');
              //           Get.offNamed('/home');
              //         }),
              //         AuthStateChangeAction<UserCreated>((context, state) {
              //           //Navigator.pushReplacementNamed(context, '/tenth');
              //           Get.offNamed('/home');
              //         }),
              //       ],
              //     )
              name: '/StartPage',
              page: () => AnimatedCardsListView())
        ]);
  }
}

// =======
// import 'package:flutter/material.dart';
// import 'package:need_moto/controllers/VehicleBookingController.dart';
// import 'package:need_moto/controllers/controllerkyc.dart';
// import 'package:need_moto/controllers/filecontroller.dart';
// import 'package:need_moto/controllers/main_controller.dart';
// import 'package:need_moto/controllers/menucontroller.dart';
// import 'package:need_moto/mywidget.dart';
// import 'package:need_moto/screens/StartingPage.dart';
// import 'package:need_moto/screens/screenshot.dart';
// import 'package:need_moto/screens/seventh.dart';
// import 'package:need_moto/screens/sixth.dart';
// import 'package:get/get.dart';
// import 'package:need_moto/screens/tenth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:need_moto/screens/Home.dart';
//
// import 'controllers/booking_controller.dart';
// import 'widget/car.dart';
// import 'widget/request.dart';
//
// void main() async {
//   //making the menu controller available
//   //throughout the app
//   //Get.put(MenuController())
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   Get.put(BookingColntroller());
//   Get.put(KycController());
//   Get.put(MyHomePageController());
//   Get.put(MainController());
//   Get.put(FileController('qFm8nd1BODSFfJLEsGNFLzjbOiN2'));
//   Get.put(VehicleBookingController());
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//         theme: ThemeData(
//           fontFamily: 'NotoSans',
//           primarySwatch: Colors.blue,
//         ),
//         // initialRoute: '/signInScreen',
//         initialRoute: '/StartPage',
//         debugShowCheckedModeBanner: false,
//         getPages: [
//           // GetPage(name: '/sixth', page: () => sixth()),
//           GetPage(name: '/home', page: () => Home()),
//           GetPage(name: '/seventh', page: () => seventh()),
//           // GetPage(name: '/tenth', page: () => Tenth()),
//           GetPage(name: '/ss', page: () => MyHomePageView()),
//           GetPage(
//               // name: '/signInScreen',
//               // page: () => SignInScreen(
//               //       providers: [
//               //         EmailAuthProvider(),
//               //       ],
//               //       actions: [
//               //         AuthStateChangeAction<SignedIn>((context, state) {
//               //           //Navigator.pushReplacementNamed(context, '/tenth');
//               //           Get.offNamed('/home');
//               //         }),
//               //         AuthStateChangeAction<UserCreated>((context, state) {
//               //           //Navigator.pushReplacementNamed(context, '/tenth');
//               //           Get.offNamed('/home');
//               //         }),
//               //       ],
//               //     )
//               name: '/StartPage',
//               page: () => AnimatedCardsListView())
//         ]);
//   }
// }
// >>>>>>> origin/main
