import 'package:flutter/material.dart';

class FuelDropField extends StatefulWidget {
  const FuelDropField({super.key});

  @override
  State<FuelDropField> createState() => _FuelDropFieldState();
}

class _FuelDropFieldState extends State<FuelDropField> {
  String dropDownValue = "";
  List<String> fuelType = [
    'Diesel',
    'Petrol',
    'Electric',
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
              hintText: "Fuel Type",
            ),
            // value: dropDownValue,
            onChanged: (value) {
              setState(() {
                dropDownValue = value!;
              });
            },
            items: fuelType
                .map((fuelTitle) =>
                    DropdownMenuItem(value: fuelTitle, child: Text(fuelTitle)))
                .toList(),
          ),
        ],
      ),
    );
  }
}
