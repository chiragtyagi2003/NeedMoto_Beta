import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:need_moto/owner/screens/received_vehicle/ratingCongratulations.dart';

// screen to rate the rider
// and give a feedback
class RatingToRider extends StatefulWidget {
  const RatingToRider({super.key});

  @override
  State<RatingToRider> createState() => _RatingToRiderState();
}

class _RatingToRiderState extends State<RatingToRider> {
  final TextEditingController _messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // Use media queries to get the available height and width of the screen
    final screenHeight = MediaQuery.of(context).size.height;

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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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
              const Text(
                "Kiran Kumar reddy",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              const Text(
                "Rate your experience",
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
                  BoxConstraints(maxHeight: screenHeight * 0.5, minHeight: screenHeight * 0.1),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RatingCongratulation()));
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
