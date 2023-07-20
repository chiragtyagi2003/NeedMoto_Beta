import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/controllers/main_controller.dart';
import 'package:intl/intl.dart';


class FormTile extends StatefulWidget {
  FormTile(
      {Key? key,
      // required this.source,
      // required this.destination,
      // required this.pickupDateTime,
      // required this.returnDateTime,
      // required this.delivery,
      // required this.purpose,
      required this.isEditable})
      : super(key: key);
  // String source;
  // String destination;
  // String pickupDateTime;
  // String returnDateTime;
  // String delivery;
  // String purpose;
  bool isEditable;

  @override
  State<FormTile> createState() => _FormTileState();
}

class _FormTileState extends State<FormTile> {
  MainController mainController = Get.find();

  final RxBool isFromValid = false.obs;
  final RxBool isToValid = false.obs;
  final RxBool isFromTimeValid = false.obs;
  final RxBool isToTimeValid = false.obs;
  final RxBool isPickupValid = false.obs;
  final RxBool isPurposeValid = false.obs;

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  TextEditingController pickupController = TextEditingController();
  TextEditingController purposeController = TextEditingController();

  late ValueNotifier<String> returnDateTimeNotifier;

  @override
  void initState() {
    super.initState();

    // Set initial values to the controllers
    fromController.text = mainController.vehicleSource.text;//widget.source;
    toController.text = mainController.vehicleDestination.text; //widget.destination;
    fromTimeController.text = mainController.pickupDateTime.text; //widget.pickupDateTime;
    toTimeController.text =  mainController.returnDateTime.text; //widget.returnDateTime;
    pickupController.text = mainController.delivery.text; //widget.delivery;
    purposeController.text = mainController.purpose.text; //widget.purpose;
  }

  @override
  void dispose() {
    // Dispose the controllers when the state is disposed
    fromController.dispose();
    toController.dispose();
    fromTimeController.dispose();
    toTimeController.dispose();
    pickupController.dispose();
    purposeController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      // padding: EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.grey.shade400,
      //     width: 1,
      //   ),
      //   borderRadius: BorderRadius.circular(8),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First row with "From" and "To" fields
          Row(
            children: [
              Expanded(
                child: widget.isEditable
                    ? TextField(
                        autofocus: false,
                        controller: fromController,
                        onChanged: (value) {
                          isFromValid.value = value.isNotEmpty;
                          setState(() {
                            mainController.vehicleSource.text = value.toString();
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'From',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      )
                    : _edit(mainController.vehicleSource.text, 'Form'),
              ),
              SizedBox(width: 8),
              Icon(Icons.compare_arrows_sharp, color: Colors.orange[600]),
              SizedBox(width: 8),
              Expanded(
                child: widget.isEditable
                    ? TextField(
                        controller: toController,
                        onChanged: (value) {
                              isToValid.value = value.isNotEmpty;
                              setState(() {
                                mainController.vehicleDestination.text = value.toString();
                              });
                        },
                        decoration: InputDecoration(
                          labelText: 'To',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      )
                    : _edit(mainController.vehicleDestination.text, 'To'),
              ),
            ],
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            height: 1,
            color: Colors.black54,
          ),

          SizedBox(height: 15),

          // Second row with date and time fields
          Row(
            children: [
              Expanded(
                child: widget.isEditable
                    ? TextField(
                  controller: mainController.pickupDateTime..text = DateFormat('dd-MM-yyyy HH:mm')
                      .format(mainController.pickUpdateTimeController.selectedDateTime.value)
                      .toString(),
                  readOnly: true,
                  onTap: () async {
                    final selectedDateTime = await mainController.pickUpdateTimeController.selectDateTime(context);
                    if (selectedDateTime != null) {
                      setState(() {
                        mainController.pickupDateTime.text = DateFormat('dd-MM-yyyy HH:mm').format(selectedDateTime);
                        mainController.durationDaysHoursController.text = mainController.calculateDurationDaysHours(mainController.pickupDateTime.text, mainController.returnDateTime.text);
                      });
                    }},
                  decoration: InputDecoration(
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(30)),
                      labelText: 'Pickup date & Time'),
                )
                    : _edit(mainController.pickupDateTime.text, 'Pickup Date and Time'),
              ),
              SizedBox(width: 8),
              Icon(Icons.calendar_today_outlined, color: Colors.orange),
              SizedBox(width: 8),
              Expanded(
                child: widget.isEditable
                    ?  TextField(
                  controller: mainController.returnDateTime..text = DateFormat('dd-MM-yyyy HH:mm')
                      .format(mainController.returndateTimeController.selectedDateTime.value)
                      .toString(),
                  readOnly: true,
                  onTap: () async {
                    final selectedDateTime = await mainController.returndateTimeController.selectDateTime(context);
                    if (selectedDateTime != null) {
                     setState(() {
                       mainController.returnDateTime.text = DateFormat('dd-MM-yyyy HH:mm').format(selectedDateTime);
                       mainController.durationDaysHoursController.text = mainController.calculateDurationDaysHours(mainController.pickupDateTime.text, mainController.returnDateTime.text);
                     });
                    }},
                  decoration: InputDecoration(
                      labelText: 'Return date & Time'),
                )
                    : _edit(mainController.returnDateTime.text, 'Return Date and Time'),
              ),
            ],
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            height: 1,
            color: Colors.black54,
          ),
          SizedBox(height: 10),
          // Third row with "Pickup/Delivery" and "Purpose" fields
          Row(
            children: [
              Expanded(
                child: widget.isEditable
                    ?  DropdownSearch(
                        popupProps: PopupProps.menu(
                          constraints: BoxConstraints(maxHeight: 200),
                          searchDelay: Duration(milliseconds: 500)),
                          items: mainController.deliveryDropDownController.option,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                // border: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(30)),
                                labelText: 'Delivery',
                            )),
                          onChanged: (value) {
                             setState(() {
                               mainController.deliveryDropDownController.setvalue(value!);
                               mainController.delivery.text = value!;
                               print('delivery: ${mainController.delivery.text}');
                             });
                          },
                        selectedItem: mainController.deliveryDropDownController.selectType,
                      )
                    : _edit(mainController.delivery.text, 'Pickup/Delivery'),
              ),
              SizedBox(width: 8),
              //Icon(Icons.compare_arrows_sharp, color: Colors.orange),
              SizedBox(width: 8),
              Expanded(
                child: widget.isEditable
                    ? TextField(
                        controller: purposeController,
                        onChanged: (value) {
                          isPurposeValid.value = value.isNotEmpty;
                          setState(() {
                            mainController.purpose.text = value.toString();
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Purpose',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      )
                    : _edit(mainController.purpose.text, 'Purpose'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _edit(String text, String lable) {
    return Container(
      margin: EdgeInsets.only(left: 18),
      decoration: BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lable,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
