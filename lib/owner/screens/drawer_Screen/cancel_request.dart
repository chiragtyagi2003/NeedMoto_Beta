import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/screens/ownerHome.dart';



class CancelRequest extends StatefulWidget {
  const CancelRequest({super.key});

  @override
  State<CancelRequest> createState() => _CancelRequestState();
}

class _CancelRequestState extends State<CancelRequest> {
  String? cancelReason;
  bool textbox = false;
  final TextEditingController _controller = TextEditingController();
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
          "Cancel Request",
          style: TextStyle(color: Colors.black),
        ),
        surfaceTintColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: const Text(
                  "Cancellation reasons",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RadioListTile(
                      activeColor: Colors.orange,
                      title: const Text(
                        "I have work with vehicle",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      value: "I have work with vehicle",
                      groupValue: cancelReason,
                      onChanged: (value) {
                        setState(() {
                          textbox = false;
                          cancelReason = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      activeColor: Colors.orange,
                      title: const Text(
                        "Vehicle is out of station",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      value: "Vehicle is out of station",
                      groupValue: cancelReason,
                      onChanged: (value) {
                        setState(() {
                          textbox = false;
                          cancelReason = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      activeColor: Colors.orange,
                      title: const Text(
                        "Vehicle is not in good condition",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      value: "Vehicle is not in good condition",
                      groupValue: cancelReason,
                      onChanged: (value) {
                        setState(() {
                          textbox = false;

                          cancelReason = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      activeColor: Colors.orange,
                      title: const Text(
                        "Other",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      value: "other",
                      groupValue: cancelReason,
                      onChanged: (value) {
                        setState(() {
                          textbox = true;
                          cancelReason = value.toString();
                        });
                      },
                    ),
                    textbox ? textfield() : Container(),
                    const SizedBox(height: 20),
                    _submitButton(context)
                  ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            )),
            backgroundColor: MaterialStateProperty.all(Colors.orange)),
        onPressed: () {
          Get.to(const OwnerHome());
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

  Widget textfield() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: TextField(
        maxLines: 10,
        controller: _controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.grey,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
