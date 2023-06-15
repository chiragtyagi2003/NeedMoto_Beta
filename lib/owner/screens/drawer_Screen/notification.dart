import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:need_moto/owner/controller/owner_request_handler.dart';


class NotificationPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  OwnerRequestHandler ownerRequestHandler = Get.find();

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('owners')
            .doc(user?.uid)
            .collection('requests')
            .snapshots(),
        builder: (context, snapshot) {
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
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }



  Widget _notificationCard(BuildContext context, DocumentSnapshot document) {

    // Extract data from the document using document['field_name']
    final vehicleName = document['vehicleName'];
    final requestDate = document['requestDate'];
    final requestFrom = document['requestFrom'];
    final requestTo = document['requestTo'];
    final requestTime = document['requestTime'];
    final requestId = document['requestID'];

    final formattedRequestDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(requestDate));
    // final expireTime = document['expireTime'];
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(boxShadow: [
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
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ))),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Customer request for your vehicle $vehicleName",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Customer requesting your vehicle from $formattedRequestDate, $requestTime.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "$requestFrom - $requestTo",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
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
                              child: Text(
                                "Decline",
                                style: TextStyle(color: Colors.red),
                              )),
                          SizedBox(width: 20),
                          TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(16, 0, 110, 0.8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                // call the function to handle accept button
                                ownerRequestHandler.handleAccept(requestId);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
  }
}
