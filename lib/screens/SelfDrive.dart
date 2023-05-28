import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:need_moto/controllers/DateController.dart';
import 'package:need_moto/controllers/Dropdown.dart';
import 'package:need_moto/screens/sixth.dart';
import 'package:need_moto/widget/myappbar.dart';
// import 'package:need_moto/views/Home.dart';
// import 'package:need_moto/views/Car_Screen.dart';

class SelfDrive extends StatelessWidget {
  final DateTimeController dateTimeController = Get.put(DateTimeController());

  TextEditingController _vehicleNeedLocations = TextEditingController();
  TextEditingController _vehicleSource = TextEditingController();
  TextEditingController _vehicleDestination = TextEditingController();
  TextEditingController _pickupDateTime = TextEditingController();
  TextEditingController _returnDateTime = TextEditingController();
  TextEditingController _delivery = TextEditingController();
  TextEditingController _purpose = TextEditingController();
  DropdownController controller = DropdownController();
  //Dropdown Controller
  DropdownController controllers = DropdownController();
  DateTimeController Controller = DateTimeController();
  //Options display
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   iconTheme: IconThemeData(color: Colors.black),
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       Spacer(
      //         flex: 2,
      //       ),
      //       Container(
      //           padding: EdgeInsets.all(15),
      //           width: 150,
      //           height: 50,
      //           child: Text(
      //             'Need Moto',
      //             style: TextStyle(
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.w600,
      //                 color: Colors.black),
      //           )),
      //       Spacer(),
      //       IconButton(onPressed: () {}, icon: Icon(Icons.search)),
      //       IconButton(onPressed: () {}, icon: Icon(Icons.person))
      //     ],
      //   ),
      // ),
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
                          items: controller.options,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            labelText: 'Seats',
                          )),
                          onChanged: (value) {
                            controller.setValue(value!);
                          },
                          selectedItem: controller.selectedItem,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
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
                              controller: TextEditingController(
                                text: DateFormat('yyyy-MM-dd HH:mm')
                                    .format(dateTimeController
                                        .selectedDateTime.value)
                                    .toString(),
                              ),
                              readOnly: true,
                              onTap: () =>
                                  dateTimeController.selectDateTime(context),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  labelText: 'Pickup date & Time'),
                            )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: Obx(() => TextField(
                              controller: TextEditingController(
                                text: DateFormat('yyyy-MM-dd HH:mm')
                                    .format(Controller.selectedDateTime.value)
                                    .toString(),
                              ),
                              readOnly: true,
                              onTap: () => Controller.selectDateTime(context),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  labelText: 'Return date and Time'),
                            )),
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
                          items: controller.option,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            labelText: 'Delivery',
                          )),
                          onChanged: (value) {
                            controller.setvalue(value!);
                          },
                          selectedItem: controller.selectType,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
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
                                    builder: (context) => sixth(
                                          seats: controllers.selectedItem,
                                          delivery: _delivery.text,
                                          vehicleLocation:
                                              _vehicleNeedLocations.text,
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
