import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/controllers/main_controller.dart';

import '../controllers/PaymentController.dart';

class ReqAccept extends StatelessWidget {
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

  MainController mainController  = Get.find();
  PaymentController paymentController = Get.find();

  ReqAccept({
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
  });




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade400,
      body: SafeArea(child:
      SingleChildScrollView(child:
      Column(
        children: [
          Row(
            children: [
              SizedBox(width: 10,),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,),
              ),
              SizedBox(width: 50,),
              Text('Request has been sent to owner',style: TextStyle(color: Colors.white),)
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [

              SizedBox(width: 160,),
              Container(width: 75,
                height: 75,
                child: Image.asset('assets/images/tick.png',color: Colors.white,),
              )
            ],
          ),
          SizedBox(height: 15,),
          Row(
            children: [

              SizedBox(width: 60,),
              Text('Your request have been approved from Owner.\n Check vehicle details and complet payment',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)
            ],
          ),
          SizedBox(height: 15,),
          Container(
            width: double.infinity,
            height: 800,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),color: Colors.white,
            ),
            padding: EdgeInsets.all(10),
            child:
            Column(
              children: [Padding(padding: EdgeInsets.all(15)),
                Container(padding: EdgeInsets.all(15),
                  width: 380,
                  height: 50,
                  decoration: BoxDecoration(border:Border.all(color: Colors.black),borderRadius: BorderRadius.circular(20),color: Colors.grey.shade400),
                  child: Text('${vehicleName}/${seats} seater/ 2000 /-',textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    //Padding(padding: EdgeInsets.all(10)),
                    Column(
                      children: [Padding(padding: EdgeInsets.all(15)),
                        Container(
                          width: 150,
                          height: 10,
                          child: Text('From',textAlign: TextAlign.left,style: TextStyle(fontSize: 10),),
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
                      child: IconButton(onPressed: () {  }, icon: Icon(Icons.swap_horiz,color: Colors.orange,),),
                    ),
                    SizedBox(width: 5,),
                    Column(
                      children: [Padding(padding: EdgeInsets.all(15)),
                        Container(
                          width: 150,
                          height: 10,
                          child: Text('To',textAlign: TextAlign.left,style: TextStyle(fontSize: 10),),
                        ),
                        Container(
                            width: 150,
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
                    //Padding(padding: EdgeInsets.all(10)),
                    Column(
                      children: [Padding(padding: EdgeInsets.all(15)),
                        Container(
                          width: 150,
                          height: 10,
                          child: Text('Pickup date and time ',textAlign: TextAlign.left,style: TextStyle(fontSize: 10),),
                        ),
                        Container(
                            width: 150,
                            height: 35,
                            child: TextField(
                                controller: TextEditingController(text: pickupDateTime),
                                enabled: false,
                                decoration: InputDecoration(hintText: '22-04-23'))),
                      ],
                    ),
                    SizedBox(
                      width: 35,
                      height: 10,
                      child: IconButton(onPressed: () {  }, icon: Icon(Icons.calendar_month_outlined,color: Colors.orange,),),
                    ),
                    SizedBox(width: 5,),
                    Column(
                      children: [Padding(padding: EdgeInsets.all(15)),
                        Container(
                          width: 150,
                          height: 10,
                          child: Text('Drop date and time',textAlign: TextAlign.left,style: TextStyle(fontSize: 10),),
                        ),
                        Container(
                            width: 150,
                            height: 35,
                            child: TextField(
                                controller: TextEditingController(text: returnDateTime),
                                enabled: false,
                                decoration: InputDecoration(hintText: '24-02-23'))),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Padding(padding: EdgeInsets.all(10)),
                    Column(
                      children: [Padding(padding: EdgeInsets.all(15)),
                        Container(
                          width: 150,
                          height: 10,
                          child: Text('Home delivery or pickup',textAlign: TextAlign.left,style: TextStyle(fontSize: 10),),
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
                    SizedBox(width: 35,),
                    Column(
                      children: [Padding(padding: EdgeInsets.all(15)),
                        Container(
                          width: 150,
                          height: 10,
                          child: Text('Purpose',textAlign: TextAlign.left,style: TextStyle(fontSize: 10),),
                        ),
                        Container(
                            width: 150,
                            height: 35,
                            child: TextField(
                                controller: TextEditingController(text: purpose),
                                enabled: false,
                                decoration: InputDecoration(hintText: 'Function'))),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                Card(
                  elevation: 10,
                  child: Container(
                      width: 325,
                      height: 300,
                    child: Column(
                      children: [Padding(padding: EdgeInsets.all(25)),
                        Row(
                          children: [
                            SizedBox(width: 130,),
                            Container(width: 50,height: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),child: Image.asset('assets/images/wheel.png'),)
                          ],
                        ),
                        SizedBox(height: 10,), 
                        Row(
                          children: [
                            SizedBox(width: 113,),
                            Container(width: 150,height: 50,child: Text('${ownerName}\n+91 ${ownerPhoneNumber}'))
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Fuel type'),
                            SizedBox(width: 100,),
                            Text(type),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Vehicle number'),
                            SizedBox(width: 20,),
                            Text(vehicleNumber),
                          ],
                        ),

                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Total Price'),
                            SizedBox(width: 20,),
                            Text(mainController.totalPriceController.text),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 150,
                      height: 50,
                      child: ElevatedButton(
                          style:ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey.shade500,
                              shape: StadiumBorder()),
                          onPressed: () {
                            paymentController.amount.value = rentalPrice as int;
                            paymentController.makePayment();
                          },
                          child: Text('Pay',style: TextStyle(color: Colors.white,fontSize: 20),)),
                    ),
                    SizedBox(width: 150,
                      height: 50,
                      child: ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor: Colors.orange,shape: StadiumBorder()),onPressed: () {}, child: Text('Cancel Ride',style: TextStyle(color: Colors.white,fontSize: 20),)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),),

      ),
    );
  }
}
