import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({super.key});

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
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
          "REFER AND EARN",
          style: TextStyle(color: Colors.black),
        ),
        surfaceTintColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Image(
            image: AssetImage("image/referandearn.jpg"),
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Earn ₹ 300 for every Friend you Refer",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Get a friend to start using Rush wheels today and earn ₹ 300 when they complete their first vehicle register or first vehicle booking",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, right: 10, bottom: 30),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(165, 255, 235, 238),
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "How it works",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.w500),
                      ),
                      const Divider(color: Colors.black),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Refer your friend with your unique referal code",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Your friend gets ₹ 300 in Rush wheels first \nvehicle register or first vehicle booking",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text(
                                "3",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Your will gets ₹ 300 after their first vehicle\n register or first vehicle booking",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                DottedBorder(
                  dashPattern: const [8, 8, 8, 8],
                  borderType: BorderType.RRect,
                  color: const Color.fromRGBO(101, 128, 26, 1),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromRGBO(227, 250, 166, 1),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "9949494949",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.share)
                          ]),
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
