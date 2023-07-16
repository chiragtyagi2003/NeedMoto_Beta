import 'package:flutter/material.dart';
import 'package:need_moto/owner/screens/drawer_Screen/customer_details.dart';
import 'package:need_moto/owner/screens/received_vehicle/trackVehicle.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        surfaceTintColor: Colors.black,
        elevation: 1,
        title: const Text(
          "Celerio - TS08EC2505",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TrackVehicle()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ride 5",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 6, 21, 152),
                        fontSize: screenHeight * 0.03,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "3000 KM",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 6, 21, 152),
                        fontSize: screenHeight * 0.03,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.black87.withOpacity(0.8),
          ),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
        ],
      ),
    );
  }

  Widget _vehicleCard(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.02),
      height: screenHeight * 0.18,
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color:  Color.fromARGB(20, 0, 0, 0),
            spreadRadius: 4,
            blurRadius: 10,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    "Name: ",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "Kiran kumar reddy",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Number: ",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "+91 9949494949",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Date: ",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "27-07-2022",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Ride KM: ",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "500",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerDetails()));
            },
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.orange[50],
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
