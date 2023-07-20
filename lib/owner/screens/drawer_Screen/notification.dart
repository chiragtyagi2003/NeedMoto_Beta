import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:need_moto/owner/controller/owner_request_handler.dart';

class NotificationPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  OwnerRequestHandler ownerRequestHandler = Get.find();

  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('owners')
            .doc(user?.uid)
            .collection('requests')
            .snapshots(),
        builder: (context, snapshot) {
          try {
            if (snapshot.hasData) {
              final documents = snapshot.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final document = documents[index];
                  return _notificationCard(context, document);
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          } catch (e) {
            return const Center(
              child: Text('An error occurred while loading notifications.'),
            );
          }
        },
      ),
    );
  }

  Widget _notificationCard(BuildContext context, DocumentSnapshot document) {
    try {
      // Extract data from the document using document['field_name']
      final vehicleName = document['vehicleName'];
      final requestDate = document['requestDate'];
      final requestFrom = document['requestFrom'];
      final requestTo = document['requestTo'];
      final requestTime = document['requestTime'];
      final requestId = document['requestID'];

      final formattedRequestDate =
          DateFormat('dd-MM-yyyy').format(DateTime.parse(requestDate));
      // final expireTime = document['expireTime'];
      return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(20, 0, 0, 0),
                spreadRadius: 4,
                blurRadius: 10)
          ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ))),
              Container(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Customer request for your vehicle $vehicleName",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Customer requesting your vehicle from $formattedRequestDate, $requestTime.",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "$requestFrom - $requestTo",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Expire in 2 hours",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  // call the handle decline function
                                  ownerRequestHandler.handleDecline(requestId);
                                },
                                child: const Text(
                                  "Decline",
                                  style: TextStyle(color: Colors.red),
                                )),
                            const SizedBox(width: 8),
                            TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(16, 0, 110, 0.8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () {
                                  // call the function to handle accept button
                                  ownerRequestHandler.handleAccept(requestId);
                                },
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    "Accept",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ));
    } catch (e) {
      return const SizedBox(); // or return an appropriate error widget here
    }
  }
}
