import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../ownerHome.dart';

class RateUs extends StatefulWidget {
  const RateUs({super.key});

  @override
  State<RateUs> createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  @override
  Widget build(BuildContext context) {
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
          "RATE US",
          style: TextStyle(color: Colors.black),
        ),
        surfaceTintColor: Colors.black,
        elevation: 1,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Image(
                image: AssetImage(
                  "image/img.jpg",
                ),
                fit: BoxFit.contain,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              child: Image(
                image: AssetImage("image/googleplay.png"),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your opinion matters to us",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              "We work super hard to serve you better and would love to know how would you rate our app?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.black87),
            ),
            const SizedBox(height: 40),
            RatingBar(
              initialRating: 0,
              minRating: 0,
              maxRating: 5,
              allowHalfRating: false,
              itemSize: 60.0,
              ratingWidget: RatingWidget(
                full: const Icon(Icons.star, color: Colors.orange),
                half: const Icon(Icons.star_half, color: Colors.orange),
                empty: const Icon(Icons.star_border, color: Colors.orange),
              ),
              onRatingUpdate: (rating) {},
            ),
            const SizedBox(height: 30),
            _submitButton(context)
          ],
        ),
      ),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const OwnerHome()));
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
