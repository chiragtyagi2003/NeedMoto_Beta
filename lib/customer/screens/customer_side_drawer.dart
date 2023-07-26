import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:need_moto/customer/screens/side_drawer/my_bookings.dart';
import 'package:need_moto/customer/screens/side_drawer/my_requests.dart';

class CustomerSideDrawer extends StatelessWidget {
  const CustomerSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();

    // Retrieve the height of the task bar
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Drawer(
      backgroundColor: const Color.fromARGB(200, 0, 0, 0),
      child: Container(
        padding: EdgeInsets.only(top: statusBarHeight),
        margin: const EdgeInsets.only(left: 30), // Add 'top' margin
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.to(MyBookings());
              },
              child: const Text(
                "My Bookings",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.to(MyRequests());
              },
              child: const Text(
                "My Requests",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {},
              child: const Text(
                "Transaction History",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                mainController.logout();
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
