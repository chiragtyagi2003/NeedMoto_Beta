import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapPanel extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelcontroller;
  const MapPanel(
      {super.key, required this.controller, required this.panelcontroller});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: EdgeInsets.zero,
      children: <Widget>[
        const SizedBox(height: 10),
        dragHandler(),
        content(),
      ],
    );
  }

  Widget content() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      child: Column(children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Today: 12:00 AM - 02:11PM",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            Text(
              "Trip History",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(
          color: Colors.black,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.circle_sharp,
                  color: Colors.green[600],
                  size: 15,
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon(Icons.remove_circle_outline_outlined)

                    const SizedBox(width: 5),
                    Text(
                      "Running",
                      style: TextStyle(
                          color: Colors.green[600],
                          fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      "20.1 KM",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const Text(
                      "7h 8m",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.remove_circle_outlined,
                  color: Colors.red[600],
                  size: 15,
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //

                    const SizedBox(width: 5),
                    Text(
                      "Stops",
                      style: TextStyle(
                          color: Colors.red[600], fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      "0 Stop",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const Text(
                      "-",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.circle_sharp,
                  color: Colors.grey[600],
                  size: 15,
                ),
                const SizedBox(width: 5),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon(Icons.remove_circle_outline_outlined)

                    SizedBox(width: 5),
                    Text(
                      "Low Network",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "1 Time",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "7h 5m",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.circle_sharp,
              color: Colors.green[600],
              size: 25,
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Moving",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Since 7h 12m",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  "Last updated : 02:18 PM, 18 Sep 2022",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 25),
        const Text(
          "Nagole Roda Chandrapuri colony, Uppdal, Hyderabad, Rangareddy, Telangana, 500039, India",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          textAlign: TextAlign.justify,
        )
      ]),
    );
  }

  Widget dragHandler() {
    return GestureDetector(
      onTap: togglePanel,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(30)),
          width: 50,
          height: 7,
        ),
      ),
    );
  }

  void togglePanel() {
    panelcontroller.isPanelOpen
        ? panelcontroller.close()
        : panelcontroller.open();
  }
}
