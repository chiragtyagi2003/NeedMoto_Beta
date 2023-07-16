import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/screens/received_vehicle/ratingToRider.dart';
import '../../controller/scratches_dropdown.dart';
import '../../object/textField.dart';

class ReceivedVehicle extends StatefulWidget {
  const ReceivedVehicle({super.key});

  @override
  State<ReceivedVehicle> createState() => _ReceivedVehicleState();
}

class _ReceivedVehicleState extends State<ReceivedVehicle> {
  ScratchesDropdownController controller = ScratchesDropdownController();
  final TextEditingController _ridingController = TextEditingController();
  final TextEditingController _damageController = TextEditingController();
  final TextEditingController _fastTagController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  final Rxn<bool> selected = Rxn<bool>();

  @override
  Widget build(BuildContext context) {
    // Use media queries to get the available height and width of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
          "RECEIVE VEHICLE",
          style: TextStyle(color: Colors.black),
        ),
        surfaceTintColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        TextInputField(
                          controller: _ridingController,
                          myLabelText: "Reading",
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            height: screenHeight * 0.1,
                            width: screenWidth * 0.2,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.black12,
                            ),
                            child: const Center(
                              child: Text(
                                "100 Km",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownSearch(
                        popupProps: const PopupProps.menu(
                          constraints: BoxConstraints(maxHeight: 200),
                        ),
                        items: controller.options,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            labelText: 'Scratches',
                          ),
                        ),
                        onChanged: (value) {
                          controller.setValue(value!);
                        },
                        // selectedItem: controller.selectedItem,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextInputField(
                      controller: _damageController,
                      myLabelText: "Damages",
                    ),
                    const SizedBox(height: 20),
                    TextInputField(
                      controller: _fastTagController,
                      myLabelText: "FastTag amount",
                    ),
                    const SizedBox(height: 20),
                    TextInputField(
                      controller: _fastTagController,
                      myLabelText: "Other Charges",
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _messageController,
                      // maxLength: 10,
                      maxLines: 10,
                      minLines: 10,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        alignLabelWithHint: true,
                        constraints:
                        const BoxConstraints(maxHeight: 400, minHeight: 50),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    otp(),
                  ],
                ),
              ),
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget otp() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Please enter OTP. Rush wheels shared with Rider",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 228, 255, 154),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: TextFormField(
                      initialValue: "",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 228, 255, 154),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: TextFormField(
                      initialValue: "",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 228, 255, 154),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: TextFormField(
                      initialValue: "",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 228, 255, 154),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: TextFormField(
                      initialValue: "",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const Icon(Icons.check_circle, color: Colors.green, size: 45),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              children: [
                Obx(
                      () => Checkbox(
                    activeColor: const Color.fromARGB(255, 33, 103, 243),
                    value: selected.value == true,
                    onChanged: (val) {
                      val == true
                          ? selected.value = true
                          : selected.value = false;
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: const Text(
                    "I have received above checked documents from Rider.",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
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
            ),
          ),
          backgroundColor:
          MaterialStateProperty.all(const Color.fromARGB(255, 0, 15, 112)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RatingToRider()),
          );
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
}
