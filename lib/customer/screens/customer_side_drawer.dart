import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/screens/side_drawer/my_bookings.dart';
import 'package:need_moto/customer/screens/side_drawer/my_requests.dart';



class CustomerSideDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Retrieve the height of the task bar
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Drawer(
      backgroundColor: Color.fromARGB(200,0, 0, 0),
      child: Container(
        padding: EdgeInsets.only(top: statusBarHeight),
        margin: EdgeInsets.only(left: 30), // Add 'top' margin
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 25),
            InkWell(
              onTap: () {
               Get.to(MyBookings());
              },
              child: Text(
                "My Bookings",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.to(MyRequests());
              },
              child: Text(
                "My Requests",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            SizedBox(height: 25),
            InkWell(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AddVehicle()));
              },
              child: Text(
                "Transaction History",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            SizedBox(height: 25),

          ],
        ),
      ),
    );
  }
}
