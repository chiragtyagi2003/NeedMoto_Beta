import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/screens/Home.dart';



class RequestRejected extends StatelessWidget {

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

  RequestRejected({
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

  void _handleBackButton() {
    // Perform your desired navigation here
    Get.to(Home());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Manually handle the back button press
        _handleBackButton();
        // Return false to prevent the default back button behavior
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.red.shade400,
        body: SafeArea(child:
        SingleChildScrollView(child:
        Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                IconButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    Get.offAll(Home());
                  },
                  icon: Icon(Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.white,),
                ),
                SizedBox(width: 35,),
                Text('Request has been sent to owner',style: TextStyle(color: Colors.white),)
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [

                SizedBox(width: 140,),
                Container(width: 75,
                  height: 75,
                  child: Image.asset('assets/images/cross.png',color: Colors.white,),
                )
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [

                SizedBox(width: 30,),
                Text('Sorry for the inconveniece we have not found \n any vehicle with your details',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)
              ],
            ),
            SizedBox(height: 15,),
            Container(
              width: double.infinity,
              height: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              child:
              Column(
                children: [Padding(padding: EdgeInsets.all(15)),
                  Container(padding: EdgeInsets.all(15),
                    width: 380,
                    height: 55,
                    decoration: BoxDecoration(border:Border.all(color: Colors.black),borderRadius: BorderRadius.circular(20),color: Colors.grey.shade400),
                    child: Text(
                      '$vehicleName / $seats Seater / $rentalPrice/-',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [Padding(padding: EdgeInsets.all(5)),
                      Column(
                        children: [Padding(padding: EdgeInsets.all(15)),
                          Container(
                            width: 150,
                            height: 15,
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
                            width: 140,
                            height: 15,
                            child: Text('To',textAlign: TextAlign.left,style: TextStyle(fontSize: 10),),
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
                    children: [Padding(padding: EdgeInsets.all(5)),
                      Column(
                        children: [Padding(padding: EdgeInsets.all(15)),
                          Container(
                            width: 150,
                            height: 15,
                            child: Text('Pickup date and time ',textAlign: TextAlign.left,style: TextStyle(fontSize: 10),),
                          ),
                          Container(
                              width: 150,
                              height: 35,
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
                        height: 10,
                        child: IconButton(onPressed: () {  }, icon: Icon(Icons.calendar_month_outlined,color: Colors.orange,),),
                      ),
                      SizedBox(width: 5,),
                      Column(
                        children: [Padding(padding: EdgeInsets.all(15)),
                          Container(
                            width: 140,
                            height: 15,
                            child: Text('Drop date and time',textAlign: TextAlign.left,style: TextStyle(fontSize: 10),),
                          ),
                          Container(
                              width: 140,
                              height: 35,
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
                    children: [Padding(padding: EdgeInsets.all(5)),
                      Column(
                        children: [Padding(padding: EdgeInsets.all(15)),
                          Container(
                            width: 150,
                            height: 15,
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
                            width: 140,
                            height: 15,
                            child: Text('Purpose',textAlign: TextAlign.left,style: TextStyle(fontSize: 10),),
                          ),
                          Container(
                              width: 140,
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
                ],
              ),
            ),
          ],
        ),
        ),

        ),
      ),
    );
  }
}