import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_auth_controller.dart';
import 'package:need_moto/owner/screens/addVehicle.dart';
import 'package:need_moto/owner/screens/drawer_Screen/offers.dart';
import 'package:need_moto/owner/screens/drawer_Screen/profile_page.dart';
import 'package:need_moto/owner/screens/drawer_Screen/refer_and_earn.dart';
import 'package:need_moto/owner/screens/drawer_Screen/vehicle_history.dart';
import 'drawer_Screen/gps.dart';
import 'drawer_Screen/notification.dart';
import 'drawer_Screen/rate_us.dart';
import 'drawer_Screen/settings.dart';

class SideDrawer extends StatelessWidget {
  OwnerAuthController ownerAuthController = Get.find();

  SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(217, 0, 0, 0),
      child: Container(
        margin: const EdgeInsets.only(left: 30),
        child: ListView(
          children: [
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.to(const ProfilePage());
              },
              child: const Text(
                "Profile",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.to(const VehicleHistory());
              },
              child: const Text(
                "Vehicle history",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.to(const AddVehicle());
              },
              child: const Text(
                "Add Vehicle",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {},
              child: const Text(
                "Payment history",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.to(NotificationPage());
              },
              child: const Text(
                "Notifications",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {},
              child: const Text(
                "Reports",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.to(const Settings());
              },
              child: const Text(
                "Settings",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.to(const Gps());
              },
              child: const Text(
                "Buy GPS",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {},
              child: const Text(
                "Subscription",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.to(const ReferAndEarn());
              },
              child: const Text(
                "Refer and earn",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.to(const Offers());
              },
              child: const Text(
                "Offers",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {},
              child: const Text(
                "Policies",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {},
              child: const Text(
                "Help & Support",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.to(const RateUs());
              },
              child: const Text(
                "Rate Us",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {},
              child: const Text(
                "My wallet",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {},
              child: const Text(
                "Your earning",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                ownerAuthController.logout();
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
