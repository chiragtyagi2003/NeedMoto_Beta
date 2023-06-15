import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/controllers/AdminRequestController.dart';
import 'package:need_moto/controllers/PaymentController.dart';

class Payments extends StatelessWidget {
  Payments({super.key});

  // Get.put(AdminRequestController());
  PaymentsController adminpayment = Get.find();

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
        child: SingleChildScrollView(
          child: Obx(
            () => ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: adminpayment.carnames.length,
              itemBuilder: (BuildContext context, int index) {
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
                                                '${adminpayment.bookingids[index]} ',
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
                                                '${adminpayment.transactionids[index]}',
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
                                                '${adminpayment.customernames[index]}',
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
                                                '${adminpayment.ownernames[index]}',
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
                                                '${adminpayment.phnos[index]} ',
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
                                                '${adminpayment.carnumber[index]} ',
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
            ),
          ),
        ),
      ),
    );
  }
}
