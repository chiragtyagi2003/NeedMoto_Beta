import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/Request_Controller.dart';

class RequestPending extends StatelessWidget {
  final requestController = Get.put(RequestController());

  String vehicleLocation;
  String source;
  String destination;
  String pickupDateTime;
  String returnDateTime;
  String delivery;
  String purpose;
  String ownerName;
  String ownerPhoneNumber;
  String type;
  String vehicleNumber;
  String vehicleName;
  String seats;
  double rentalPrice;
  String base_12;
  String base_24;

  RequestPending({
    required this.vehicleLocation,
    required this.source,
    required this.destination,
    required this.pickupDateTime,
    required this.returnDateTime,
    required this.delivery,
    required this.purpose,
    required this.ownerName,
    required this.ownerPhoneNumber,
    required this.type,
    required this.vehicleNumber,
    required this.vehicleName,
    required this.seats,
    required this.rentalPrice,
    required this.base_12,
    required this.base_24,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Request has been sent to owner.',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 140,
                  ),
                  Container(
                    width: 75,
                    height: 75,
                    child: Image.asset(
                      'assets/images/hourglass.png',
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 70,
                  ),
                  Text(
                    'You will get response\nwithin short time. Please wait for it.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(15)),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: 380,
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade400),
                      child: Text(
                        '$vehicleName / $seats Seater / $rentalPrice/-',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(5)),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.all(15)),
                            Container(
                              width: 150,
                              height: 15,
                              child: Text(
                                'From',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            Container(
                                width: 150,
                                height: 35,
                                child: TextField(
                                    controller: TextEditingController(text: source),
                                    enabled: false,
                                    decoration: InputDecoration(hintText: 'hyderabad'))),
                          ],
                        ),
                        SizedBox(
                          width: 35,
                          height: 10,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.swap_horiz,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.all(15)),
                            Container(
                              width: 140,
                              height: 15,
                              child: Text(
                                'To',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            Container(
                                width: 140,
                                height: 35,
                                child: TextField(
                                    controller: TextEditingController(text: destination),
                                    enabled: false,
                                    decoration: InputDecoration(hintText: 'Chittoor'))),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(5)),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.all(15)),
                            Container(
                              width: 150,
                              height: 15,
                              child: Text(
                                'Pickup date and time ',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            Container(
                                width: 150,
                                height: 45,
                                child: TextField(
                                    controller: TextEditingController(text: pickupDateTime),
                                    enabled: false,
                                    decoration: InputDecoration(
                                        hintText: '22-04-23',
                                        hintStyle: TextStyle(fontSize: 14),
                                    ))),
                          ],
                        ),
                        SizedBox(
                          width: 35,
                          height: 15,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.all(15)),
                            Container(
                              width: 140,
                              height: 15,
                              child: Text(
                                'Drop date and time',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            Container(
                                width: 140,
                                height: 45,
                                child: TextField(
                                    controller: TextEditingController(text: returnDateTime),
                                    enabled: false,
                                    decoration: InputDecoration(
                                        hintText: '24-02-23',
                                        hintStyle: TextStyle(fontSize: 14),
                                    ))),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(5)),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.all(15)),
                            Container(
                              width: 150,
                              height: 15,
                              child: Text(
                                'Home delivery or pickup',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            Container(
                                width: 150,
                                height: 35,
                                child: TextField(
                                    controller: TextEditingController(text: delivery),
                                    enabled: false,
                                    decoration: InputDecoration(hintText: 'Pickup'))),
                          ],
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.all(15)),
                            Container(
                              width: 145,
                              height: 15,
                              child: Text(
                                'Purpose',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            Container(
                                width: 145,
                                height: 35,
                                child: TextField(
                                    controller: TextEditingController(text: purpose),
                                    enabled: false,
                                    decoration: InputDecoration(hintText: 'Function'))),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: StadiumBorder()),
                          onPressed: () {},
                          child: Text(
                            'Cancel Request',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                            textAlign: TextAlign.center,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
