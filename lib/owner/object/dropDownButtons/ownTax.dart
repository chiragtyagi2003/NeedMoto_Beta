import 'package:flutter/material.dart';
import 'package:need_moto/owner/object/dropDownButtons/tones.dart';
import 'package:need_moto/owner/object/dropDownButtons/withdriverdrop.dart';

import '../textField.dart';

class OwnTaxDropField extends StatefulWidget {
  const OwnTaxDropField({super.key});

  @override
  State<OwnTaxDropField> createState() => _OwnTaxDropFieldState();
}

class _OwnTaxDropFieldState extends State<OwnTaxDropField> {
  bool checkOwn = false;
  bool checkTax = false;
  final TextEditingController _seatingCapacityController =
      TextEditingController();

  String dropDownValue = "";
  List<String> owntax = [
    'Own',
    'Tax',
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Own / Tax Plate",
            ),
            // value: dropDownValue,
            onChanged: (value) {
              setState(() {
                dropDownValue = value!;
                if (value == 'Own') {
                  checkOwn = true;
                  checkTax = false;
                } else {
                  checkTax = true;
                  checkOwn = false;
                }
              });
            },
            items: owntax
                .map((ownTitle) =>
                    DropdownMenuItem(value: ownTitle, child: Text(ownTitle)))
                .toList(),
          ),
          const SizedBox(height: 20),
          checkOwnField(),
          checkTaxField(),
        ],
      ),
    );
  }

  Widget checkOwnField() {
    return checkOwn
        ? Column(
            children: [
              TextInputField(
                  controller: _seatingCapacityController,
                  myLabelText: "Seating Capacity"),
              const SizedBox(height: 20),
              const WithDriverDropField(),
            ],
          )
        : Container();
  }

  Widget checkTaxField() {
    return checkTax
        ? const Column(
            children: [
              TonesOwnField(),
              // TextInputField(controller:_TaxCapacityController , myLabelText: "Loading Capacity")
            ],
          )
        : Container();
  }
}
