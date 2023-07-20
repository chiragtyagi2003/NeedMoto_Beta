import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controllers/admin_request_controller.dart';

class AdminRequests extends StatefulWidget {
  const AdminRequests({super.key});

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
    super.initState();
    adminRequest.fetchBookingData().then((_) {
      try {
        fetchCustomerNames();
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[600],
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
    });
  }

  Future<void> fetchCustomerNames() async {
    try {
      if (adminRequest.requestsData.isNotEmpty) {
        // Fetch customer names only if bookingData is not empty
        customerNames = await Future.wait(
            adminRequest.requestsData.map((bookingSnapshot) async {
          Map<String, dynamic>? bookingData =
              bookingSnapshot.data() as Map<String, dynamic>?;
          String custUID = bookingData?['userId'];
          return await adminRequest.fetchCustomerName(custUID);
        }));
      }

      setState(() {
        isDataLoaded = true; // Set the flag to indicate that data is loaded
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
      setState(() {
        isDataLoaded = true; // Still update the state to rebuild the widget
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookings',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
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
        child: isDataLoaded
            ? ListView.builder(
                //physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: adminRequest.requestsData.length,
                itemBuilder: (BuildContext context, int index) {
                  try {
                    // Access the booking data for the current index
                    DocumentSnapshot requestSnapshot =
                        adminRequest.requestsData[
                            index]; // Access the data from the booking snapshot
                    Map<String, dynamic>? requestData =
                        requestSnapshot.data() as Map<String, dynamic>?;
                    // Access the fields from the booking snapshot
                    String carName = requestData?['vehicleName'];
                    String pickUpDateTime = requestData?['pickupDateTime'];
                    String returnDateTime = requestData?['returnDateTime'];
                    String source = requestData?['source'];
                    String destination = requestData?['destination'];

                    String requestTime = adminRequest.calculateHoursDifference(
                        pickUpDateTime, returnDateTime);
                    String? customerName =
                        customerNames.isNotEmpty ? customerNames[index] : null;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(children: [
                        Column(
                          children: [
                            const SizedBox(
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Car name  :',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    carName,
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Customer name :',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    // '${adminbooking.customernames[index]}',
                                                    '$customerName',
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Request time : ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    '$requestTime hrs',
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Distance : ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'From : ',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        source,
                                                        style: const TextStyle(
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'To : ',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        destination,
                                                        style: const TextStyle(
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
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "Error",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey[600],
                      textColor: Colors.black,
                      fontSize: 16.0,
                    );

                    return Container(); // Return an empty container to handle the error gracefully
                  }
                })
            : const Center(
                child:
                    CircularProgressIndicator(), // Show a centered loading indicator while fetching data
              ),
      ),
    );
  }
}
