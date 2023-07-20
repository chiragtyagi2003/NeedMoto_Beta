import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:need_moto/admin/controllers/admin_booking_controller.dart';
import 'package:need_moto/admin/controllers/payment_controller.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  // Get.put(AdminRequestController());
  AdminPaymentsController adminPayment = Get.find();
  AdminBookingController adminbooking = Get.find();

  // Fetch customer names beforehand
  List<String?> customerNames = [];
  List<String?> ownerNames = [];
  List<String?> ownerPhoneNumbers = [];
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    adminbooking.fetchBookingData().then((_) {
      fetchCustomerNames();
      fetchOwnerNames();
      fetchOwnerPhoneNumbers();
    });
  }

  Future<void> fetchCustomerNames() async {
    if (adminbooking.bookingData.isNotEmpty) {
      try {
        customerNames = await Future.wait(
            adminbooking.bookingData.map((bookingSnapshot) async {
              Map<String, dynamic>? bookingData =
              bookingSnapshot.data() as Map<String, dynamic>?;
              String custUID = bookingData?['userId'];
              return await adminbooking.fetchCustomerName(custUID);
            }));
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
    }

    setState(() {
      isDataLoaded = true;
    });
  }

  Future<void> fetchOwnerNames() async {
    if (adminbooking.bookingData.isNotEmpty) {
      try {
        ownerNames = await Future.wait(
            adminbooking.bookingData.map((bookingSnapshot) async {
              Map<String, dynamic>? bookingData =
              bookingSnapshot.data() as Map<String, dynamic>?;
              String ownerUID = bookingData?['ownerId'];
              return await adminbooking.fetchOwnerName(ownerUID);
            }));
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
    }

    setState(() {
      isDataLoaded = true;
    });
  }

  Future<void> fetchOwnerPhoneNumbers() async {
    if (adminbooking.bookingData.isNotEmpty) {
      try {
        ownerPhoneNumbers = await Future.wait(
            adminbooking.bookingData.map((bookingSnapshot) async {
              Map<String, dynamic>? bookingData =
              bookingSnapshot.data() as Map<String, dynamic>?;
              String ownerUID = bookingData?['ownerId'];
              return await adminbooking.fetchOwnerPhoneNumber(ownerUID);
            }));
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
    }
    setState(() {
      isDataLoaded = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payments',
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
                itemCount: adminbooking.bookingData.length,
                itemBuilder: (BuildContext context, int index) {
                  try {
                    // Access the booking data for the current index
                    DocumentSnapshot bookingSnapshot = adminbooking.bookingData[
                        index]; // Access the data from the booking snapshot
                    String bookingId = bookingSnapshot.id;
                    Map<String, dynamic>? bookingData =
                        bookingSnapshot.data() as Map<String, dynamic>?;
                    // Access the fields from the booking snapshot
                    String transactionId = bookingData?['transaction_id'];
                    String vehicleNumber = bookingData?['vehicleNumber'];
                    String? customerName =
                        customerNames.isNotEmpty ? customerNames[index] : null;
                    String? ownerName =
                        ownerNames.isNotEmpty ? ownerNames[index] : null;
                    String? ownerPhoneNumber = ownerPhoneNumbers.isNotEmpty
                        ? ownerPhoneNumbers[index]
                        : null;
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
                                height: 220,
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
                                                    'Booking ID :',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    bookingId,
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
                                                    'Transaction ID :',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    transactionId,
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              // Seats

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
                                                    '$customerName',
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              // Rental Price Per Km and Per Km

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Owner Name : ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    '$ownerName',
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
                                                    'Owner Number :',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    '$ownerPhoneNumber ',
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
                                                    'Vehicle Number :',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    '$vehicleNumber ',
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                    ),
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
                    print('Error while building list item: $e');
                    return Container(); // Or any placeholder widget to display when an error occurs
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
