import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_auth_controller.dart';


class CustomerSideDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(217, 0, 0, 0),
      child: Container(
        margin: EdgeInsets.only(left: 30),
        child: ListView(
          children: [
            SizedBox(height: 25),
            InkWell(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: Text(
                "My Bookings",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            SizedBox(height: 25),
            InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                    // MaterialPageRoute(
                    //   builder: (context) => VehicleHistroty(),
                    // ));
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
