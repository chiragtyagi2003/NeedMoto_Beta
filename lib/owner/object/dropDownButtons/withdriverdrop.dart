import 'package:flutter/material.dart';

class WithDriverDropField extends StatefulWidget {
  const WithDriverDropField({super.key});

  @override
  State<WithDriverDropField> createState() => _WithDriverDropFieldState();
}

class _WithDriverDropFieldState extends State<WithDriverDropField> {
  String dropDownValue = "";
  List<String> driverType = [
    'With Driver',
    'Without Driver',
    'Door Step available',
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
              hintText: "With",
            ),
            // value: dropDownValue,
            onChanged: (value) {
              setState(() {
                dropDownValue = value!;
              });
            },
            items: driverType
                .map((driverTitle) => DropdownMenuItem(
                    value: driverTitle, child: Text(driverTitle)))
                .toList(),
          ),
        ],
      ),
    );
  }
}
