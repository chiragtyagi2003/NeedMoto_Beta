
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/admin/controllers/admin_booking_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../controllers/admin_request_controller.dart';

class AdminRequests extends StatefulWidget {
  AdminRequests({super.key});

  @override
  State<AdminRequests> createState() => _AdminRequestsState();
}

class _AdminRequestsState extends State<AdminRequests> {
  AdminRequestController adminRequest = Get.find();


  // Fetch customer names beforehand
  List<String?> customerNames = [];
  bool isDataLoaded = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminRequest.fetchBookingData().then((_) {
      fetchCustomerNames();
    });
  }

  Future<void> fetchCustomerNames() async {
    if (adminRequest.requestsData.isNotEmpty) {
      // Fetch customer names only if bookingData is not empty
      customerNames = await Future.wait(adminRequest.requestsData.map((bookingSnapshot) async {
        Map<String, dynamic>? bookingData = bookingSnapshot.data() as Map<String, dynamic>?;
        String custUID = bookingData?['userId'];
        return await adminRequest.fetchCustomerName(custUID);
      }));
    }

    print('Customer Names: $customerNames');
    setState(() {
      isDataLoaded = true; // Set the flag to indicate that data is loaded
    }); // Update the state to rebuild the widget with the fetched data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookings',
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
        child: isDataLoaded ? ListView.builder(
          //physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: adminRequest.requestsData.length,
          itemBuilder: (BuildContext context, int index){
            // Access the booking data for the current index
            DocumentSnapshot requestSnapshot = adminRequest.requestsData[index]; // Access the data from the booking snapshot
            Map<String, dynamic>? requestData = requestSnapshot.data() as Map<String, dynamic>?;
            // Access the fields from the booking snapshot
            String carName = requestData?['vehicleName'];
            String pickUpDateTime = requestData?['pickupDateTime'];
            String returnDateTime = requestData?['returnDateTime'];
            String source = requestData?['source'];
            String destination = requestData?['destination'];

            String requestTime = adminRequest.calculateHoursDifference(pickUpDateTime, returnDateTime);
            String? customerName = customerNames.isNotEmpty ? customerNames[index] : null;
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
                                            'Customer name :',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            // '${adminbooking.customernames[index]}',
                                            '$customerName',
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
                                            'Deafult km',
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
        ) : Center(
          child: CircularProgressIndicator(), // Show a centered loading indicator while fetching data
        ),
      ),
    );
  }
}
