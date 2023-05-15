import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatelessWidget {
  final String carImage;
  final String milage;
  final String ownername;
  final String phonenumber;

  final String carName;
  final String people;
  final String bags;
  final String carPrice;
  final String carRating;
  final bool isRotated;
  final String type;
  final String speed;
  const DetailsPage({
    Key? key,
    required this.milage,
    required this.carImage,
    required this.speed,
    required this.carName,
    required this.people,
    required this.bags,
    required this.carPrice,
    required this.carRating,
    required this.isRotated,
    required this.type,
    required this.ownername,
    required this.phonenumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), //appbar size
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.05,
            ),
            child: SizedBox(
              height: size.width * 0.01,
              width: size.width * 0.1,
              child: InkWell(
                onTap: () {
                  Get.back(); //go back to home page
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: size.height * 0.025,
                ),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: size.width * 0.15,
          title: Text(
            carName,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xff3b22a1),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: Container(
            height: size.height,
            width: size.height,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 254, 252, 252),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 28.0),
                      child: ListView(
                        children: [
                          isRotated
                              ? Hero(
                                  tag: carName,
                                  child: Image.asset(
                                    carImage,
                                    height: size.width * 0.5,
                                    width: size.width * 0.8,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(pi),
                                  child: Image.asset(
                                    carImage,
                                    height: size.width * 0.5,
                                    width: size.width * 0.8,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                type,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.star,
                                color: Colors.yellow[800],
                                size: size.width * 0.06,
                              ),
                              Text(
                                carRating,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.yellow[800],
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                carName,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '₹$carPrice',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '/day',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: size.width * 0.025,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.03,
                            ),
                            child: Text(
                              'Specifications',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.055,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            child: ListView(
                              scrollDirection: Axis.horizontal,

                              // mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                buildStat(
                                  Icons.speed,
                                  // UniconsLine.dashboard,
                                  '$speed Kmph',
                                  'Speed',
                                  size,
                                ),
                                buildStat(
                                  Icons.car_rental,
                                  '$milage km/l',
                                  'Mileage',
                                  size,
                                ),
                                buildStat(
                                  Icons.people,
                                  // UniconsLine.users_alt,
                                  'People',
                                  '( $people )',
                                  size,
                                ),
                                buildStat(
                                  Icons.shopping_bag,
                                  // UniconsLine.briefcase,
                                  'Bags',
                                  '( $bags )',
                                  size,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.03,
                            ),
                            child: Text(
                              'Owner Details',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.055,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              height: size.height * 0.15,
                              width: size.width * 0.9,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.07,
                                      width: size.width * 0.15,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Align(
                                            child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        )),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                        vertical: size.height * 0.015,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ownername,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size.width * 0.05,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            phonenumber,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              fontSize: size.width * 0.032,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    bookbutton(size),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildStat(
    IconData icon,
    String title,
    String desc,
    Size size,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.015,
      ),
      child: SizedBox(
        height: size.width * 0.32,
        width: size.width * 0.28,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: size.width * 0.03,
              left: size.width * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Color(0xff3b22a1),
                  size: size.width * 0.08,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.width * 0.02,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Align bookbutton(Size size) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: EdgeInsets.only(
        bottom: size.height * 0.01,
      ),
      child: SizedBox(
        height: size.height * 0.07,
        width: size.width,
        child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xff3b22a1),
            ),
            child: Align(
              child: Text(
                'Book Now',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
