import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_main_controller.dart';
import 'package:need_moto/owner/screens/received_vehicle/ratingCongratulations.dart';

// screen to rate the rider
// and give a feedback
class RatingToRider extends StatefulWidget {

  String bookingId;

  RatingToRider({
    required this.bookingId,
});

  @override
  State<RatingToRider> createState() => _RatingToRiderState();
}

class _RatingToRiderState extends State<RatingToRider> {
  final TextEditingController _messageController = TextEditingController();
  OwnerMainController mainController = Get.find();


  void addReceivedVehicle() async {
    // Get the current user ID
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a reference to the bookings collection
    CollectionReference bookingsCollection = firestore.collection('bookings');

    // Create a document ID using the parameter value and timestamp
    String documentId = widget.bookingId;

    print("DOCUMENTI ID: ${documentId}");

    // update fields in bookings
    await bookingsCollection.doc(documentId).update({
      // Add your data fields here
      'owner_reading': mainController.ownerReadingController.text,
      'owner_scratches': mainController.ownerScratchesController.text,
      'owner_damages': mainController.ownerDamageController.text,
      'owner_fast_tag_amount': mainController.ownerFastTagController.text,
      'owner_other_charges': mainController.ownerOtherChargesController.text,
      'owner_message_controller': mainController.ownerMessageController.text,
      'owner_message_to_customer': mainController.ownerMessageToCustomerController.text,
      'owner_rating_to_rider': mainController.ownerRatingToRiderController.text,

      // change status of received_by_owner
      'received_by_owner': true,
    });

    print('updated');

  }

  @override
  Widget build(BuildContext context) {
    // Use media queries to get the available height and width of the screen
    final screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('bookings')
            .doc(widget.bookingId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Text('Booking document not found.');
          }

          final bookingData = snapshot.data!.data()!;

          return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('customers')
                  .doc(bookingData['userId'])
                  .get(),
              builder: (context, customerSnapshot) {
                if (customerSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                    width: 50,  // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    color: Colors.black.withOpacity(0.8), // Adjust the opacity (0.5 means 50% transparent)
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Adjust the color of the indicator
                      ),
                    ),
                  );
                }

                if (customerSnapshot.hasError) {
                  return Text('Error: ${customerSnapshot.error}');
                }

                if (!customerSnapshot.hasData ||
                    !customerSnapshot.data!.exists) {
                  return Text('Customer details not found.');
                }

                final customerData = customerSnapshot.data!.data()!;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
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
                "Rating to Rider",
                style: TextStyle(color: Colors.black),
              ),
              surfaceTintColor: Colors.black,
              elevation: 1,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 50),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(80)),
                      child: const CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.amber,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${customerData['name']}",
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "${customerData['phone']}",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    const SizedBox(height: 5),
                    RatingBar(
                      initialRating: 0,
                      minRating: 0,
                      maxRating: 5,
                      allowHalfRating: true,
                      itemSize: 40.0,
                      ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.red),
                        half: const Icon(Icons.star_half, color: Colors.red),
                        empty: const Icon(Icons.star_border, color: Colors.red),
                      ),
                      onRatingUpdate: (rating) {
                        // Rating is updated
                        print('rating update to: $rating');
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _messageController,
                      // maxLength: 10,
                      maxLines: 10,
                      minLines: 5,
                      decoration: InputDecoration(
                        // hintText: 'Message',
                        labelText: 'Message',
                        alignLabelWithHint: true,
                        constraints:
                        BoxConstraints(maxHeight: screenHeight * 0.5,
                            minHeight: screenHeight * 0.1),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            )),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _submitButton(context)
                  ],
                ),
              ),
            ),
            // bottomNavigationBar: BottomTab(),
          );
          });
        });
  }

  Widget _submitButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                )),
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 0, 15, 112))),
        onPressed: () {

          addReceivedVehicle();

          print("Called ADD RECEIVED VEHICLE");


          Get.to(RatingCongratulation());
        },
        child: const Center(
          child: Text(
            "Submit",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
