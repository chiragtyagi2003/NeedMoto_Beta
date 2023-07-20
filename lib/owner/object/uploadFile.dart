import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_tile_document_controller.dart';

class UploadDocument extends StatelessWidget {
  UploadDocument(
      {super.key,
      required this.filename,
      required this.filetype,
      required this.showexp});
  String filename;
  String filetype;
  bool showexp;

  final TileDocumentController tileDocController =
      Get.put(TileDocumentController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        leading: Container(
          width: 60,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(184, 5, 67, 153)),
          child: Center(
              child: Text(
            filetype,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  filename,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black45,
                      fontWeight: FontWeight.w400),
                ),
                const Text('2.5 MB'),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            LinearProgressIndicator(value: tileDocController.progressBar.value),
            const SizedBox(height: 5),
            showexp ? expDate() : Container(),
          ],
        ),
      ),
    );
  }

  Widget expDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Exp Date:",
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black45, fontSize: 14),
        ),
        const SizedBox(width: 5),
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(176, 232, 255, 59)),
            child: const Text(
              "DD",
              style: TextStyle(fontSize: 13),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(176, 232, 255, 59)),
            child: const Text(
              "MM",
              style: TextStyle(fontSize: 13),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(176, 232, 255, 59)),
            child: const Text(
              "YYYY",
              style: TextStyle(fontSize: 13),
            ),
          ),
        ]),
      ],
    );
  }
}
