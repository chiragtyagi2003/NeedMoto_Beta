import 'package:flutter/material.dart';

class VehicleHistory extends StatelessWidget {
  const VehicleHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Vehicle History",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        children: [
          // Divider(color: Colors.black),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
          _vehicleCard(context),
          const SizedBox(height: 10),
          _addButton(context),
        ],
      ),
      // bottomNavigationBar: BottomTab(),
    );
  }

  Widget _vehicleCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: MediaQuery.of(context).size.height * 0.16,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0), spreadRadius: 4, blurRadius: 10)
      ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    "Name: ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                  Text(
                    "Calerio",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Number: ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                  Text(
                    "TS08EC2505",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Ride: ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                  Text(
                    "5",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Ride KM: ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                  Text(
                    "3000",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => CarDetails()));
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.orange[50]),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.orange,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _addButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 100),
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          )),
          backgroundColor: MaterialStateProperty.all(Colors.orange[600]),
        ),
        onPressed: () {},
        child: const Center(
          child: Text(
            "Add Vehicle",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
