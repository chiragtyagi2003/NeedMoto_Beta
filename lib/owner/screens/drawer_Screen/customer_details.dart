import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'customer_Accept.dart';

class CustomerDetails extends StatefulWidget{

  String bookingId;


  CustomerDetails({
    required this.bookingId,
});



  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  TextEditingController _feedbackController = TextEditingController();



  @override
  Widget build(BuildContext context) {
     return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
         future: FirebaseFirestore.instance.collection('bookings').doc(widget.bookingId).get(),
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
               future: FirebaseFirestore.instance.collection('customers').doc(bookingData['userId']).get(),
               builder: (context, customerSnapshot) {
                 if (customerSnapshot.connectionState == ConnectionState.waiting) {
                   return CircularProgressIndicator();
                 }

                 if (customerSnapshot.hasError) {
                   return Text('Error: ${customerSnapshot.error}');
                 }

                 if (!customerSnapshot.hasData || !customerSnapshot.data!.exists) {
                   return Text('Customer details not found.');
                 }

                 final customerData = customerSnapshot.data!.data()!;


                 return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Customer Details",
            style: TextStyle(color: Colors.black),
          ),
          surfaceTintColor: Colors.black,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(children: [
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(70)),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.amber,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${customerData['name']}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("+91 ${customerData['phone']}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45)),
                  RatingBarIndicator(
                      rating: 4,
                      itemCount: 5,
                      itemSize: 30.0,
                      itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ))
                ]),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Given Date",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                        Text("${bookingData['received_date']}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Time",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                        Text("${bookingData['received_time']}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Reading",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                        Text("${bookingData['reading']}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total duration",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                        Text("${bookingData['total_duration']}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ride km",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                        Text("${bookingData['ride_km']}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Received date",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                        Text("${bookingData['submit_date']}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Time",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                        Text("${bookingData['submit_time']}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Scratches",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                        Text("${bookingData['scratches']}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Damages",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                        Text("${bookingData['damages']}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Fastage amount",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                        Text("${bookingData['fast_tag_amount']}/-",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Other charges",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                        Text("${bookingData['other_charges']}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 25),
                    Text("Message",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54)),
                    SizedBox(height: 13),
                    Text("${bookingData['message']}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    SizedBox(height: 25),
                    Text("Given address",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54)),
                    SizedBox(height: 13),
                    Text(
                        "5-48/3, Sri lakshmi ganapathi nilayam, Road no. 7, near saibaba temple Boduppal, peerzadiguda, Hyd, Telangana - 500092",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    SizedBox(height: 25),
                    Text("Customer address",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54)),
                    SizedBox(height: 13),
                    Text(
                        "5-48/3, Sri lakshmi ganapathi nilayam, Road no. 7, near saibaba temple Boduppal, peerzadiguda, Hyd, Telangana - 500092",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    SizedBox(height: 25),
                    Text("Received address",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54)),
                    SizedBox(height: 13),
                    Text(
                        "5-48/3, Sri lakshmi ganapathi nilayam, Road no. 7, near saibaba temple Boduppal, peerzadiguda, Hyd, Telangana - 500092",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    SizedBox(height: 20),
                    Divider(
                      height: 5,
                      color: Colors.black,
                    ),
                    // SizedBox(height: 20),
                    // Center(
                    //   child: Text(
                    //     "Rate you experiance",
                    //     style: TextStyle(
                    //         color: Color.fromARGB(217, 6, 0, 191),
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    // SizedBox(height: 10),
                    // Center(
                    //   child: RatingBar(
                    //     initialRating: 0,
                    //     minRating: 0,
                    //     maxRating: 5,
                    //     allowHalfRating: true,
                    //     itemSize: 30.0,
                    //     ratingWidget: RatingWidget(
                    //       full: const Icon(Icons.star, color: Colors.orange),
                    //       half: const Icon(Icons.star_half, color: Colors.orange),
                    //       empty:
                    //           const Icon(Icons.star_border, color: Colors.grey),
                    //     ),
                    //     onRatingUpdate: (rating) {
                    //       // Rating is updated
                    //       print('rating update to: $rating');
                    //     },
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 40,
                    // ),
                    // TextField(
                    //   controller: _feedbackController,
                    //   decoration: InputDecoration(
                    //     contentPadding:
                    //         EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    //     hintText: 'Message',
                    //     enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //         borderSide: const BorderSide(
                    //           color: Colors.grey,
                    //         )),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(30),
                    //       borderSide: const BorderSide(
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ),
                    //   textAlign: TextAlign.start,
                    //   maxLines: 7,
                    //   minLines: 6,
                    // ),
                  ],
                ),
              ),
              //_submitButton(context),
              SizedBox(height: 30),
            ],
          ),
        ),
        );
         });
     });

  }

  Widget _submitButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          )),
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(198, 29, 6, 157)),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CustomerAccept()));
        },
        child: Center(
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
