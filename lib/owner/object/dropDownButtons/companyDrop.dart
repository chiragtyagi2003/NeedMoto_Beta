import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_main_controller.dart';

class DropField extends StatefulWidget {
  const DropField({
    Key? key,
  }) : super(key: key);

  @override
  _DropFieldState createState() => _DropFieldState();
}

class _DropFieldState extends State<DropField> {
  String dropDownValue = "";
  List<String> company = [
    'Maruti Suzuki',
    'Hyundai Motors',
    'Tata Motors',
    'Kia Motor'
  ];

  OwnerMainController mainController = Get.find();
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
              hintText: "Company",
            ),
            // value: dropDownValue,
            onChanged: (value) {
              setState(() {
                mainController.vehicleCompanyController =
                    value! as TextEditingController;
                dropDownValue = value;
              });
            },
            items: company
                .map((companyTitle) => DropdownMenuItem(
                    value: companyTitle, child: Text(companyTitle)))
                .toList(),
          ),
        ],
      ),
    );
  }
}
