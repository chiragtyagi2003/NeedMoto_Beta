import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/Request_Controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyRequests extends StatefulWidget {
  MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  RequestController customerRequestController = Get.find();

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;


  @override
  void initState() {
    // TODO: implement initState
    customerRequestController.fetchMyRequests(currentUserId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Requests',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Obx(
              () => ListView.builder(
            //physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: customerRequestController.myRequests.length,
            itemBuilder: (BuildContext context, int index) {
              // Access the booking data for the current index
              DocumentSnapshot bookingSnapshot = customerRequestController.myRequests[index]; // Access the data from the booking snapshot
              Map<String, dynamic>? bookingData = bookingSnapshot.data() as Map<String, dynamic>?;
              // Access the fields from the booking snapshot
              String carName = bookingData?['vehicleName'];
              String carNumber = bookingData?['vehicleNumber'];
              String ownerName = 'Default';
              String custUID = bookingData?['userId'];
              String pickUpDateTime = bookingData?['pickupDateTime'];
              String returnDateTime = bookingData?['returnDateTime'];
              String source = bookingData?['source'];
              String destination = bookingData?['destination'];

              String requestTime = customerRequestController.calculateHoursDifference(pickUpDateTime, returnDateTime);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 1,
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Vehicle Details
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        left: 20.0,
                                        right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        // Vehicle Name

                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Car name  :',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              '${carName}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                         Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Request time : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              '$requestTime hrs',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Distance : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              'Default km',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'From : ',
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                Text(
                                                  '${source}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'To : ',
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                Text(
                                                  '${destination}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
