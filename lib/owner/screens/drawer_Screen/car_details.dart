import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/screens/drawer_Screen/customer_details.dart';
import 'package:need_moto/owner/screens/received_vehicle/trackVehicle.dart';

class CarDetails extends StatefulWidget {
  final String vehicleName;
  final String vehicleNumber;

  const CarDetails({
    super.key,
    required this.vehicleName,
    required this.vehicleNumber,
  });

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  final user = FirebaseAuth.instance.currentUser;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchBookings(
      String ownerId, String vehicleNumber) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('ownerID', isEqualTo: ownerId)
          .where('vehicleNumber', isEqualTo: vehicleNumber)
          .get();

      return querySnapshot.docs;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Data not found.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.black,
        fontSize: 16.0,
      );
      // You can choose to return an empty list or rethrow the exception here.
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        surfaceTintColor: Colors.black,
        elevation: 1,
        title: Text(
          "${widget.vehicleName} - ${widget.vehicleNumber}",
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
        future: fetchBookings(user!.uid, widget.vehicleNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          try {
            final bookings = snapshot.data ?? [];

            if (bookings.isEmpty) {
              return Center(child: const Text('No bookings found.'));
            }

            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                final bookingId =
                    booking.id; // Access the ID of the current booking document
                final ownerId = booking['ownerID'];
                final vehicleNumber = booking['vehicleNumber'];
                final userId = booking['userId'];

                return _vehicleCard(
                    context, bookingId, ownerId, vehicleNumber, userId);
              },
            );
          } catch (e) {
            Fluttertoast.showToast(
              msg: "Data not found.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey[600],
              textColor: Colors.black,
              fontSize: 16.0,
            );
            return const Center(
                child: Text("An Error Occurred")); // return empty list
          }
        },
      ),
    );
  }

  Widget _vehicleCard(BuildContext context, String bookingId, String ownerId,
      String assignedVehicleNumber, String userId) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    Future<Map<String, dynamic>> fetchRideDataAndCustomerDetails(
        String userId, String assignedVehicleNumber, String bookingId) async {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('customers')
          .doc(userId)
          .get();

      if (!userSnapshot.exists) {
        Fluttertoast.showToast(
          msg: "Data not found.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[600],
          textColor: Colors.black,
          fontSize: 16.0,
        );
        return {}; // User document does not exist
      }

      final customerData = userSnapshot.data() as Map<String, dynamic>;

      final bookingSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookingId)
          .get();

      if (!bookingSnapshot.exists) {
        Fluttertoast.showToast(
          msg: "Data not found.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[600],
          textColor: Colors.black,
          fontSize: 16.0,
        );
        return {}; // Booking document does not exist
      }

      final bookingData = bookingSnapshot.data() as Map<String, dynamic>;

      return {
        'userData': customerData,
        'bookingData': bookingData,
      };
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.25,
      padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03, vertical: screenHeight * 0.02),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            spreadRadius: 4,
            blurRadius: 10,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder<Map<String, dynamic>>(
                future: fetchRideDataAndCustomerDetails(
                    userId, assignedVehicleNumber, bookingId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  try {
                    if (snapshot.hasError || snapshot.data == null) {
                      return const Text('Error: Data not available');
                    }

                    final customerData =
                        snapshot.data!['userData'] as Map<String, dynamic>?;
                    final bookingData =
                        snapshot.data!['bookingData'] as Map<String, dynamic>?;

                    if (customerData == null) {
                      return const Text('Error: Invalid customer data format');
                    }

                    if (bookingData == null) {
                      return const Text('Error: Invalid booking data format');
                    }

                    final name = customerData['name'] ?? '';
                    final phoneNumber = customerData['phone'] ?? '';
                    final receivedDate = bookingData['received_date'] ?? '';
                    final rideKm = bookingData['ride_km'] ?? '';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Name: ",
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Number: ",
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              phoneNumber,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Date: ",
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              receivedDate,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Ride KM: ",
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              rideKm,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "Error.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey[600],
                      textColor: Colors.black,
                      fontSize: 16.0,
                    );
                    // You can return an error widget or any fallback widget in case of an error.
                    return const Text(
                        'An error occurred while building the data.');
                  }
                },
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              try {
                final DocumentSnapshot document = await FirebaseFirestore
                    .instance
                    .collection('bookings')
                    .doc(bookingId)
                    .get();

                if (!document.exists) {
                  throw Exception('Booking not found');
                }

                bool fieldValue = document['ongoing_ride'] as bool;
                bool fieldValue2 = document['received_by_owner'] as bool;

                if (fieldValue && !fieldValue2) {
                  // Navigate to a track vehicle page
                  Get.to(TrackVehicle(
                    bookingId: bookingId,
                  ));
                }
                // if the ride is completed but the vehicle is not received by owner
                else if (!fieldValue && !fieldValue2) {
                  // Navigate to customer details page
                  Get.to(TrackVehicle(
                    bookingId: bookingId,
                  ));
                } else {
                  // Navigate to customer details page
                  Get.to(CustomerDetails(bookingId: bookingId));
                }
              } catch (error) {
                Fluttertoast.showToast(
                  msg: "Error.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey[600],
                  textColor: Colors.black,
                  fontSize: 16.0,
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.orange[50],
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
