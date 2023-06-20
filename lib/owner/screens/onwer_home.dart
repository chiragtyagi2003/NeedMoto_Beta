import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_main_controller.dart';
import 'package:need_moto/owner/object/rush_wheel_card.dart';
import 'package:need_moto/owner/screens/add_vehicle.dart';

import 'nav_drawer.dart';

class OwnerHome extends StatefulWidget {
  // OwnerHome({super.key, required this.name, required this.phoneNumber});
  // String name;
  // String phoneNumber;

  @override
  State<OwnerHome> createState() => _OwnerHomeState();
}

class _OwnerHomeState extends State<OwnerHome> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  OwnerMainController mainController = Get.find();

  Future<void> fetchData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('owners')
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        setState(() {
          mainController.ownerNameController.text = data['name'];
          mainController.ownerPhoneNumberController.text = data['phone_number'];
        });
      }
    }
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> fetchVehicles() async {
    final user = FirebaseAuth.instance.currentUser;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('owners')
        .doc(user!.uid)
        .collection('vehicles')
        .get();

    return querySnapshot.docs;
  }




  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(159, 108, 255, 1),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _size.height * 0.4,
              width: _size.width,
              color: Color.fromRGBO(159, 108, 255, 1),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       IconButton(
                  //         icon: Icon(
                  //           Icons.notifications_none_outlined,
                  //           size: 30,
                  //         ),
                  //         onPressed: () {},
                  //       ),
                  //     ]),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(70)),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.amber,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    // widget.name,
                    mainController.ownerNameController.text,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Text(
                    // "+91 ${widget.phoneNumber}",
                    "+91 ${mainController.ownerPhoneNumberController.text}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white60),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Text("Welcome to Rush Wheels",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 30),
            // addVehicle(context),
            // RushWheel(),
            // SizedBox(height: 25),
            // RushWheel(),
            // SizedBox(height: 25),

            Column(
              children: [
             FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
                future: fetchVehicles(),
                builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No vehicles found.');
                } else {
                  return Column(
                children: snapshot.data!.map((doc) => RushWheel(doc)).toList(),
                    );
                 }
                }),
              ],
            ),
            SizedBox(height: 10,),
            _addButton(context)
          ],
        ),
      ),
      // bottomNavigationBar: BottomTab(),
    );
  }

  Widget addVehicle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, left: 30, right: 30),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Color.fromRGBO(212, 235, 255, 1),
          // color: Colors.green[500],
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        Text(
          "Get money by adding your vehicle to rush wheels and give for rent 1 day to so many days",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ]),
    );
  }

  Widget _addButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.width * 0.1,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          )),
          backgroundColor: MaterialStateProperty.all(Colors.orange[600]),
        ),
        onPressed: () {
          Get.offAll(() => AddVehicle());
        },
        child: Center(
          child: Text(
            "Add Vehicle",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
