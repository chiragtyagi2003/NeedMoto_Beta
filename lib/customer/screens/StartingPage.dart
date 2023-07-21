import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/screens/NewLogin.dart';
import 'package:need_moto/customer/screens/NewSignup.dart';

class AnimatedCardsListView extends StatefulWidget {
  const AnimatedCardsListView({super.key});

  @override
  _AnimatedCardsListViewState createState() => _AnimatedCardsListViewState();
}

const data = [
  {
    "Title": "Self Driving",
    "content":
        "Rent one of our cutting-edge self-driving cars and experience the future of transportation. Our vehicles are equipped with state-of-the-art technology and safety features to provide a seamless and safe autonomous driving experience.",
    "buttonText": "Let's Drive",
  },
  {
    "Title": "Need Heavy Vehicles..?\nWe got you!",
    "content":
        "Need to move heavy equipment or materials? Rent one of our heavy vehicles, designed to handle even the toughest jobs with ease.",
    "buttonText": 'Create Account Now!',
  },
  {
    "Title": "Carry your Goods with us",
    "content":
        " Our cargo vans and trucks are perfect for transporting goods of all kinds. With a range of sizes available, we've got you covered for all your cargo needs.",
    "buttonText": "Let's go!",
  },
  {
    "Title": "Industrial Works",
    "content":
        "Our industrial vehicles are built to withstand the demands of any job site. Whether you need a crane truck, bulldozer, or excavator, we've got the equipment you need to get the job done.",
    "buttonText": "Interested!",
  },
  {
    "Title": "Farming",
    "content":
        " Our farm vehicles are perfect for all your agricultural needs. From tractors to combines, we've got the machinery you need to help you run your farm efficiently and effectively.",
    "buttonText": "Join Us",
    // 'colors': Color.fromARGB(255, 237, 139, 69),
  },
];

class _AnimatedCardsListViewState extends State<AnimatedCardsListView> {
  final controller = ScrollController();
  final double itemSize = 230;
  void onListenerController() {
    setState(() {});
  }

  @override
  void initState() {
    controller.addListener(onListenerController);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(onListenerController);
    super.dispose(); // Call super.dispose()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  // go to login page
                  Get.to(LoginPage());
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF20A4F3)),
                child: const Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {

                  // go to sign up page
                  Get.to(const SignupPage());
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF182B3A)),
                child: const Text(
                  'Register',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Need Moto',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() => Stack(
        children: [
          _listView(),
        ],
      );
  Widget _listView() => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(25, 25, 15, 10),
              child: Text(
                'Why do you "Need Moto" ...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              // show all types of services of app
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  controller: controller,
                  itemBuilder: (context, index) {
                    final itemOffset = index * itemSize;
                    final difference = controller.offset - itemOffset;
                    final percent = 1 - (difference / (itemSize / 2));
                    double opacity = percent;
                    double scale = percent;

                    if (opacity > 1.0) opacity = 1.0;
                    if (opacity < 0.0) opacity = 0.0;
                    if (scale > 1.0) scale = 1.0;
                    return Opacity(
                      opacity: opacity,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(scale, 1.0),
                        child: Container(

                            // alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF20A4F3),
                                    Color(0xFF182B3A)
                                  ],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xffDDDDDD),
                                    blurRadius: 6.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0.0, 0.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width*0.2,
                            height: MediaQuery.of(context).size.height*0.3,
                            // alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(18, 18, 8, 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index]['Title'].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            //fontSize: 19
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                      data[index]['content'].toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 18.0, bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color.fromARGB(
                                                255, 255, 200, 0)),
                                        child: Text(
                                          data[index]['buttonText'].toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
}
