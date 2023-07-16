import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ownerHome.dart';

// screen to show congratulations and points scored

class RatingCongratulation extends StatefulWidget {
  const RatingCongratulation({super.key});

  @override
  State<RatingCongratulation> createState() => _RatingCongratulationState();
}

class _RatingCongratulationState extends State<RatingCongratulation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Congratulations!",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Text(
              "You have received 20 points",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
            ),
            Stack(
              children: [
                const Image(
                  image: AssetImage("assets/images/design.png"),
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.23),
                  child: const Center(
                    child: Text(
                      "20",
                      style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              "LEVEL 3",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _oKButton(context),
          ],
        ),
      ),
    );
  }

  // widget for ok button at bottom of screen
  Widget _oKButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
        onPressed: () {
          Get.to(OwnerHome());
        },
        child: const Center(
          child: Text(
            "OK",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
