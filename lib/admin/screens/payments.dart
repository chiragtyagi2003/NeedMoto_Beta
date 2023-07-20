import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/admin/controllers/admin_booking_controller.dart';
import 'package:need_moto/admin/controllers/payment_controller.dart';

class Payments extends StatefulWidget {
  Payments({super.key});

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
    // TODO: implement initState
    super.initState();
    adminbooking.fetchBookingData().then((_) {
      fetchCustomerNames();
      fetchOwnerNames();
      fetchOwnerPhoneNumbers();
    });
  }

  Future<void> fetchCustomerNames() async {
    if (adminbooking.bookingData.isNotEmpty) {
      // Fetch customer names only if bookingData is not empty
      customerNames =
      await Future.wait(adminbooking.bookingData.map((bookingSnapshot) async {
        Map<String, dynamic>? bookingData =
        bookingSnapshot.data() as Map<String, dynamic>?;
        String custUID = bookingData?['userId'];
        return await adminbooking.fetchCustomerName(custUID);
      }));
    }

    print('Customer Names: $customerNames');
    setState(() {
      isDataLoaded = true; // Set the flag to indicate that data is loaded
    }); // Update the state to rebuild the widget with the fetched data
  }

  Future<void> fetchOwnerNames() async {
    if (adminbooking.bookingData.isNotEmpty) {
      ownerNames =
      await Future.wait(adminbooking.bookingData.map((bookingSnapshot) async {
        Map<String, dynamic>? bookingData =
        bookingSnapshot.data() as Map<String, dynamic>?;
        String ownerUID = bookingData?['ownerId'];
        return await adminbooking.fetchOwnerName(ownerUID);
      }));
    }
    setState(() {
      isDataLoaded = true;
    });
  }

  Future<void> fetchOwnerPhoneNumbers() async {
    if (adminbooking.bookingData.isNotEmpty) {
      ownerPhoneNumbers =
      await Future.wait(adminbooking.bookingData.map((bookingSnapshot) async {
        Map<String, dynamic>? bookingData =
        bookingSnapshot.data() as Map<String, dynamic>?;
        String ownerUID = bookingData?['ownerId'];
        return await adminbooking.fetchOwnerPhoneNumber(ownerUID);
      }));
    }
    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payments',
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
        child: isDataLoaded
            ? ListView.builder(
          //physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: adminbooking.bookingData.length,
          itemBuilder: (BuildContext context, int index) {
            // Access the booking data for the current index
            DocumentSnapshot bookingSnapshot = adminbooking.bookingData[index]; // Access the data from the booking snapshot
            String bookingId = bookingSnapshot.id;
            Map<String, dynamic>? bookingData = bookingSnapshot.data() as Map<String, dynamic>?;
            // Access the fields from the booking snapshot
            String transactionId = bookingData?['transaction_id'];
            String vehicleNumber = bookingData?['vehicleNumber'];
            String? customerName = customerNames.isNotEmpty ? customerNames[index] : null;
            String? ownerName = ownerNames.isNotEmpty ? ownerNames[index] : null;
            String? ownerPhoneNumber = ownerPhoneNumbers.isNotEmpty ? ownerPhoneNumbers[index] : null;
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
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Booking ID :',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            '${bookingId}',
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
                                            'Transaction ID :',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            '${transactionId}',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Seats

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
                                            '${customerName}',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Rental Price Per Km and Per Km

                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Owner Name : ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            '${ownerName}',
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
                                            'Owner Number :',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            '${ownerPhoneNumber} ',
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
                                            'Vehicle Number :',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            '${vehicleNumber} ',
                                            style: TextStyle(
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
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
