import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/screens/customer_side_drawer.dart';
import 'package:need_moto/customer/screens/side_drawer/my_requests.dart';
import 'package:need_moto/customer/widget/myappbar.dart';
import 'package:need_moto/owner/screens/login.dart';

import 'SelfDrive.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const CustomerSideDrawer(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10)),
              const Align(
                alignment: Alignment.center,
              ),
              Text(
                'Welcome to Need Moto',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue.shade100,
                ),
                width: 370,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'You can book vehicle for local long drive \n with driver or without driver and commercial \n purpose also you can book',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelfDrive()));
                        },
                        child: Container(
                          width: 250,
                          height: 50,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [Colors.orange, Colors.orangeAccent],
                                  stops: [0.1, 0.7]),
                              borderRadius: BorderRadius.circular(25)),
                          child: const Center(
                            child: Text(
                              'Find Vehicle',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Rent your Vehicle',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.lightGreenAccent.shade100,
                ),
                width: 370,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Get money by adding your vehicle to \n rush wheels and give for rent 1 day \n to so many days',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                        onTap: () {

                          // go to owner login screen
                         Get.to(LoginScreen());
                        },
                        child: Container(
                          width: 250,
                          height: 50,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [Colors.orange, Colors.orangeAccent],
                                  stops: [0.1, 0.7]),
                              borderRadius: BorderRadius.circular(25)),
                          child: const Center(
                            child: Text(
                              'Add Vehicle',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 370,
                height: 200,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.hourglass_bottom),
      //   backgroundColor: Colors.orange,
      //   onPressed: () {
      //     Get.to(MyRequests());
      //   },
      // ),
    );
  }
}
