import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapPanel extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  const MapPanel({
    super.key,
    required this.controller,
    required this.panelController,
  });

  @override
  Widget build(BuildContext context) {
    // Use media queries to get the available height and width of the screen

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
      child: Column(
        children: [
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
              buildStatusWidget(
                Icons.circle_sharp,
                Colors.green[600]!,
                "Running",
                "20.1 KM",
                "7h 8m",
              ),
              buildStatusWidget(
                Icons.remove_circle_outlined,
                Colors.red[600]!,
                "Stops",
                "0 Stop",
                "-",
              ),
              buildStatusWidget(
                Icons.circle_sharp,
                Colors.grey[600]!,
                "Low Network",
                "1 Time",
                "7h 5m",
              ),
            ],
          ),
          const SizedBox(height: 20),
          buildMovingWidget(),
          const SizedBox(height: 25),
          const Text(
            "Nagole Roda Chandrapuri colony, Uppdal, Hyderabad, Rangareddy, Telangana, 500039, India",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget buildStatusWidget(
      IconData icon,
      Color color,
      String title,
      String value1,
      String value2,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
          size: 15,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 5),
            Text(
              title,
              style:
              TextStyle(color: color, fontWeight: FontWeight.w500),
            ),
            Text(
              value1,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Text(
              value2,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildMovingWidget() {
    return Row(
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
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
              "Last updated: 02:18 PM, 18 Sep 2022",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          ],
        ),
      ],
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
    panelController.isPanelOpen ? panelController.close() : panelController.open();
  }
}
