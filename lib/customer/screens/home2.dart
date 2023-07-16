import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:need_moto/customer/controllers/controller.dart';
import 'package:need_moto/customer/screens/rateOwner.dart';
import 'package:need_moto/customer/screens/ridedone.dart';
import 'package:need_moto/customer/screens/submitVehicle.dart';

class HomePage extends StatelessWidget {
  final Controller controller1 = Get.put(Controller());
  List<Widget> pages = [
    // RideComplete(),
    // SubmitVehicle(),
    // RateOwner(),
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller1.currentIndex.value) {
        case 0:
          return pages[0];
        case 1:
          return pages[1];
        case 2:
          return pages[2];
        default:
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Payment done ₹4000',
                style: TextStyle(fontSize: 15),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 31, 211, 37),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 31, 211, 37),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8, bottom: 20),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.3)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, left: 30, right: 30),
                                child: Text(
                                  'Your ride is started',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 18.0,
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 15.0),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Reading',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                          '665 Km',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    FDottedLine(
                                      color: Colors.white,
                                      height: 60.0,
                                      strokeWidth: 1.0,
                                      dottedLength: 3.0,
                                      space: 2.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Ride Completion Time',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                          '23.5 hrs',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 231, 250, 109),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 27.0, right: 27, top: 20, bottom: 20),
                        child: Text(
                          'You received a 4 digit OTP as SMS to registered mobile number. Please share with owner while giving vehicle to owner.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 45, right: 45),
                      child: Text(
                        'Ride Completed',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(200, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(0),
                    ),
                    onPressed: () {
                      // Get.to(RideComplete(
                      //
                      // ));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 28.0, bottom: 30, left: 20, right: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 10,
                      shadowColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, left: 15, right: 15, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/profile.png'),
                              radius: 50, // Set the size of the avatar
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                Text(
                                  'Abhinandan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '+91 9949494949',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ReturnStars(4)
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Fuel type',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Petrol',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Vehicle Number',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'TS08EC2505',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Message',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Vehicle is ready to pickup',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pickup Address',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '5-48/3, Sri lakshmi ganapathi nilayam, Road no. 7,near saibaba temple Boduppal, peerzadiguda, Hyd,Telangana - 500092',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Obx(() => BottomNavigationBar(
                  currentIndex: Get.find<Controller>().currentIndex.value,
                  onTap: (index) => Get.find<Controller>().changePage(index),
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), label: 'Profile'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings'),
                  ],
                )),
          );
      }
    });
  }
}

Widget ReturnStars(double rating) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (index) {
      if (index < rating.floor()) {
        return Icon(Icons.star, color: Colors.orange);
      } else if (index < rating) {
        return Icon(Icons.star_half, color: Colors.orange);
      } else {
        return Icon(Icons.star_border, color: Colors.grey);
      }
    }),
  );
}
