import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/DateController.dart';
import 'package:need_moto/customer/screens/chooseVehicle.dart';
import '../controllers/Dropdown.dart';
import 'package:intl/intl.dart';
import 'package:need_moto/customer/widget/myappbar.dart';


class SelfDrive extends StatefulWidget {
  @override
  State<SelfDrive> createState() => _SelfDriveState();
}

class _SelfDriveState extends State<SelfDrive> {
  final DateTimeController pickUpdateTimeController = DateTimeController();
  final DateTimeController returndateTimeController = DateTimeController();
  TextEditingController _vehicleNeedLocations = TextEditingController();
  TextEditingController _vehicleSource = TextEditingController();
  TextEditingController _vehicleDestination = TextEditingController();
  TextEditingController _pickupDateTime = TextEditingController();
  TextEditingController _returnDateTime = TextEditingController();
  TextEditingController _delivery = TextEditingController();
  TextEditingController _purpose = TextEditingController();
  TextEditingController _filterSeats = TextEditingController();
  DropdownController deliveryDropDownController = DropdownController();
  DropdownController seatsDropDownController = DropdownController();

  //Options display
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: Drawer(
        child: Text('drawer'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(10)),

                Text(
                  'Enter Vehicle Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                //Customer details

                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, bottom: 20, top: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        //Controller usage
                        child: DropdownSearch(
                          popupProps: PopupProps.menu(
                            constraints: BoxConstraints(maxHeight: 200),
                          ),
                          items: seatsDropDownController.options,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            labelText: 'Seats',
                          )),
                          onChanged: (value) {
                            seatsDropDownController.setValue(value!);
                            _filterSeats = value!;
                          },
                          selectedItem: seatsDropDownController.selectedItem,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _vehicleSource,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Source'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _vehicleDestination,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Destination'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: Obx(() => TextField(
                              controller: _pickupDateTime..text = DateFormat('dd-MM-yyyy HH:mm')
                              .format(pickUpdateTimeController.selectedDateTime.value)
                              .toString(),
                              readOnly: true,
                              onTap: () async {
                              final selectedDateTime = await pickUpdateTimeController.selectDateTime(context);
                                if (selectedDateTime != null) {
                                _pickupDateTime.text = DateFormat('dd-MM-yyyy HH:mm').format(selectedDateTime);
                                print('pickup date time: ${_pickupDateTime.text}');
                                print('pickup date time: $_pickupDateTime.text');
                                }},
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  labelText: 'Pickup date & Time'),
                            )
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      Container(
                        width: 350,
                        height: 60,
                        child: Obx(() => TextField(
                          controller: _returnDateTime..text = DateFormat('dd-MM-yyyy HH:mm')
                              .format(returndateTimeController.selectedDateTime.value)
                              .toString(),
                          readOnly: true,
                          onTap: () async {
                            final selectedDateTime = await returndateTimeController.selectDateTime(context);
                            if (selectedDateTime != null) {
                              _returnDateTime.text = DateFormat('dd-MM-yyyy HH:mm').format(selectedDateTime);
                              print('return date time: ${_returnDateTime.text}');
                            }},
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Return date & Time'),
                        )
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        //Controller usage
                        child: DropdownSearch(
                          popupProps: PopupProps.menu(
                              constraints: BoxConstraints(maxHeight: 200),
                              searchDelay: Duration(milliseconds: 500)),
                          items: deliveryDropDownController.option,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            labelText: 'Delivery',
                          )),
                          onChanged: (value) {
                            deliveryDropDownController.setvalue(value!);
                            _delivery.text = value!;
                            print('delivery: ${_delivery.text}');
                          },
                          selectedItem: deliveryDropDownController.selectType,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _purpose,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Purpose'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      //car details display button
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChooseVehicle(
                                          seats: seatsDropDownController.selectedItem,
                                          delivery: _delivery.text,
                                          vehicleLocation: _vehicleNeedLocations.text,
                                          source: _vehicleSource.text,
                                          destination: _vehicleDestination.text,
                                          pickupDateTime: _pickupDateTime.text,
                                          returnDateTime: _returnDateTime.text,
                                          purpose: _purpose.text,
                                        )));
                          },
                          child: Container(
                            width: 250,
                            height: 50,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.orange,
                                  Colors.orangeAccent
                                ], stops: [
                                  0.1,
                                  0.7
                                ]),
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Text(
                                'Find Vehicle',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),

                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
