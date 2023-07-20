import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_main_controller.dart';
import 'package:need_moto/owner/object/rush_wheel_card.dart';
import 'package:need_moto/owner/screens/addVehicle.dart';
import 'nav_drawer.dart';

// Owner home screen
class OwnerHome extends StatefulWidget {
  const OwnerHome({Key? key});

  @override
  State<OwnerHome> createState() => _OwnerHomeState();
}

class _OwnerHomeState extends State<OwnerHome> {
  // Instance of owner's main controller
  OwnerMainController mainController = Get.find();

  @override
  void initState() {
    super.initState();
    mainController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(159, 108, 255, 1),
        actions: [
          IconButton(
            icon: const Icon(
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
              height: size.height * 0.4,
              width: size.width,
              color: const Color.fromRGBO(159, 108, 255, 1),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.amber,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    mainController.ownerNameController.text,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "+91 ${mainController.ownerPhoneNumberController.text}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Welcome to Need Moto",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                // Fetch vehicles of the owner and display them in a list
                FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
                  future: mainController.fetchVehicles(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text("Can't load data.");
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No vehicles found.');
                    } else {
                      return Column(
                        children: snapshot.data!
                            .map((doc) => RushWheel(doc))
                            .toList(),
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            _addButton(context),
          ],
        ),
      ),
    );
  }

  // Widget for adding a vehicle
  Widget addVehicle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(212, 235, 255, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Text(
            "Get money by adding your vehicle to Rush Wheels and give for rent 1 day to many days",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Widget for the "Add Vehicle" button
  Widget _addButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.width * 0.1,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.orange[600]),
        ),
        onPressed: () {
          Get.offAll(() => const AddVehicle());
        },
        child: const Center(
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
