import 'package:flutter/material.dart';

import '../gps_tabscreen/all_screen.dart';

class Gps extends StatefulWidget {
  const Gps({super.key});

  @override
  State<Gps> createState() => _GpsState();
}

class _GpsState extends State<Gps> {
  TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
          backgroundColor: Colors.deepPurple[100],

          /// APPBAR
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
              "GPS",
              style: TextStyle(color: Colors.black),
            ),
            surfaceTintColor: Colors.blue,
            elevation: 1,
            bottom: const TabBar(
              tabs: [
                Tab(
                    child: Text(
                  "All",
                  style: TextStyle(color: Colors.black),
                )),
                Tab(
                    child:
                        Text("Stopped", style: TextStyle(color: Colors.black))),
                Tab(
                    child:
                        Text("Moving", style: TextStyle(color: Colors.black))),
                Tab(
                    child: Text("Low Network",
                        style: TextStyle(color: Colors.black))),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AllGPS(),
              AllGPS(),
              AllGPS(),
              AllGPS(),
            ],
          )),
    );
  }
}
