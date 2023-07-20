import 'package:flutter/material.dart';

class TonesOwnField extends StatefulWidget {
  const TonesOwnField({super.key});

  @override
  State<TonesOwnField> createState() => _TonesOwnFieldState();
}

class _TonesOwnFieldState extends State<TonesOwnField> {
  String dropDownValue = "";
  List<String> tonesType = [
    '4 Tones',
    '5 Tones',
    '6 Tones',
    '7 Tones',
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
              hintText: "Tones",
            ),
            // value: dropDownValue,
            onChanged: (value) {
              setState(() {
                dropDownValue = value!;
              });
            },
            items: tonesType
                .map((tonesTitle) => DropdownMenuItem(
                    value: tonesTitle, child: Text(tonesTitle)))
                .toList(),
          ),
        ],
      ),
    );
  }
}
