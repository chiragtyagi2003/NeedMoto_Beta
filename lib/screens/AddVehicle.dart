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

class AddVehicle extends StatelessWidget {
  TextEditingController _average = TextEditingController();
  TextEditingController _base12 = TextEditingController();
  TextEditingController _base24 = TextEditingController();
  TextEditingController _brand = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _distancerange = TextEditingController();
  TextEditingController _kmpl = TextEditingController();
  TextEditingController _model = TextEditingController();
  TextEditingController _ownername = TextEditingController();
  TextEditingController _priceperday = TextEditingController();
  TextEditingController _priceperhour = TextEditingController();
  TextEditingController _priceperkm = TextEditingController();
  TextEditingController _numofseats = TextEditingController();
  TextEditingController _type = TextEditingController();
  TextEditingController _vehiclenumber = TextEditingController();
  DropdownController controller = DropdownController();

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
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _brand,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Company'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _model,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Model'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _vehiclenumber,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Vehicle Number'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _type,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Vehicle Type'),
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
                          controller: _average,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Average Speed'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _kmpl,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Mileage(kmpl)'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _distancerange,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Range'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      Container(
                        width: 350,
                        height: 60,
                        child: SizedBox(
                          height: 100,
                          child: TextField(
                            controller: _ownername,

                            maxLines: null, // Set this
                            expands: true, // and this
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                labelText: 'Owner name'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _base12,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Base price (12 hrs)'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _base24,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Base price (24 hrs)'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _priceperday,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Price per day'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _priceperkm,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              labelText: 'Price per km'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: _priceperhour,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Price per Hour'),
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),

                      TextField(
                          controller: _description,
                          maxLines: 5,
                          minLines: 3,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Description')),
                      SizedBox(
                        height: 25,
                      ),
                      //car details display button
                      GestureDetector(
                          onTap: () {},
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
                                'Add Vehicle',
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
