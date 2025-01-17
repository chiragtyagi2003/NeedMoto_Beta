import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/screens/received_vehicle/receivedVehicle.dart';
import 'package:need_moto/owner/screens/received_vehicle/trackingMap.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TrackVehicle extends StatefulWidget {
  final String bookingId;

  const TrackVehicle({
    super.key,
    required this.bookingId,
  });

  @override
  State<TrackVehicle> createState() => _TrackVehicleState();
}

class _TrackVehicleState extends State<TrackVehicle> {
  bool forAndroid = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('bookings')
            .doc(widget.bookingId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('Booking document not found.');
          }

          final bookingData = snapshot.data!.data()!;

          try {
            return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('customers')
                    .doc(bookingData['userId'])
                    .get(),
                builder: (context, customerSnapshot) {
                  if (customerSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      width: 10, // Adjust the width as needed
                      height: 40, // Adjust the height as needed
                      color: Colors.grey.withOpacity(
                          1.0), // Adjust the opacity (0.5 means 50% transparent)
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors
                              .white), // Adjust the color of the indicator
                        ),
                      ),
                    );
                  }

                  if (customerSnapshot.hasError) {
                    return Text('Error: ${customerSnapshot.error}');
                  }

                  if (!customerSnapshot.hasData ||
                      !customerSnapshot.data!.exists) {
                    return const Text('Customer details not found.');
                  }

                  final customerData = customerSnapshot.data!.data()!;

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
                        "CUSTOMER DETAILS",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 25),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TrackingMap()));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                height: 53,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(227, 250, 166, 1),
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 15, 159, 20),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Track vehicle",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 15, 159, 20),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.green[100],
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color.fromARGB(255, 15, 159, 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              60, 255, 205, 210),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.email_outlined,
                                            size: 23,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              88, 200, 230, 201),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.phone_outlined,
                                            size: 23,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.85,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(70),
                                        ),
                                        child: const CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.grey,
                                          backgroundImage: NetworkImage(
                                            "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${customerData['name']}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "+91 ${customerData['phone']}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black45,
                              ),
                            ),
                            RatingBarIndicator(
                              rating: 2.5,
                              itemCount: 5,
                              itemSize: 25.0,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.redAccent,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 20),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(20, 0, 0, 0),
                                    spreadRadius: 4,
                                    blurRadius: 10,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Given Date",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        "${bookingData['received_date']}",
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Time",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        "${bookingData['received_time']}",
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Reading",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 17,
                                        ),
                                      ),
                                      const Text(
                                        "",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Need time",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 17,
                                        ),
                                      ),
                                      const Text(
                                        "24 Hours",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Duration",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 17,
                                        ),
                                      ),
                                      const Text(
                                        "14:26:45",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Increase duration",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 17,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          if (forAndroid)
                                            const Text(
                                              "48",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          else
                                            const Text(""),
                                          Switch(
                                            activeColor: Colors.green,
                                            activeThumbImage:
                                                const NetworkImage(
                                              "https://i.pinimg.com/originals/7b/dd/1b/7bdd1bc7db7fd48025d4e39a0e2f0fd8.jpg",
                                            ),
                                            activeTrackColor: Colors.black12,
                                            inactiveThumbColor: Colors.white,
                                            inactiveTrackColor:
                                                const Color.fromARGB(
                                                    255, 189, 188, 188),
                                            splashRadius: 50.0,
                                            value: forAndroid,
                                            onChanged: (value) {
                                              setState(() {
                                                forAndroid = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Given address",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "5-48/3, Sri lakshmi ganapathi nilayam, Road no. 7, near saibaba temple Boduppal, peerzadiguda, Hyd, Telangana - 500092",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Customer address",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "5-48/3, Sri lakshmi ganapathi nilayam, Road no. 7, near saibaba temple Boduppal, peerzadiguda, Hyd, Telangana - 500092",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            _receivedButton(context, widget.bookingId),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } catch (e) {
            Fluttertoast.showToast(
              msg: "Error.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey[600],
              textColor: Colors.black,
              fontSize: 16.0,
            );
            return const Text("Data not found.");
          }
        });
  }

  Widget _receivedButton(BuildContext context, String bookingId) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(181, 30, 136, 229)),
        ),
        onPressed: () async {
          try {
            final DocumentSnapshot document = await FirebaseFirestore.instance
                .collection('bookings')
                .doc(bookingId)
                .get();

            if (!document.exists) {
              throw Exception('Booking not found');
            }

            bool fieldValue = document['ongoing_ride'] as bool;
            bool fieldValue2 = document['received_by_owner'] as bool;

            if (fieldValue) {
              Fluttertoast.showToast(
                msg: 'Please wait for the ride to complete!',
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.grey[800],
                textColor: Colors.white,
              );
              // if the ride is completed but vehicle is not received by the owner
            } else if (!fieldValue && !fieldValue2) {
              // Navigate to customer details page
              Get.to(ReceivedVehicle(
                bookingId: bookingId,
              ));
            }
          } catch (error) {
            Fluttertoast.showToast(
              msg: "Error.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey[600],
              textColor: Colors.black,
              fontSize: 16.0,
            );
          }
        },
        child: const Center(
          child: Text(
            "Receive Vehicle",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
