import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/screens/StarRating.dart';
import 'package:need_moto/customer/screens/points.dart';

class RateOwner extends StatelessWidget {
  const RateOwner({super.key});
  void onRated(double rating) {
    // Do something with the rating
  }
  @override
  Widget build(BuildContext context) {
    int rating = 3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'RATING TO OWNER',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Container(
            child: Center(
              child: Column(children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.png'),
                  radius: 50, // Set the size of the avatar
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      'Abhinandan',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 25),
                    Text('Rate your Experience',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    StarRating(
                      maxRating: 5,
                      rating: 0,
                      onRated: onRated,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: '',
                          hintText: 'Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade700],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8, left: 30, right: 30),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      onPressed: () {
                        Get.to(Points());
                      },
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
