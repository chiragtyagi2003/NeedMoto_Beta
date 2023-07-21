import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/widget/kycpopup.dart';
import '../controllers/filecontroller.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    Key? key,
    required this.seats,
    required this.vehicleLocation,
    required this.source,
    required this.destination,
    required this.pickupDateTime,
    required this.returnDateTime,
    required this.delivery,
    required this.purpose,
  }) : super(key: key);
  final RxString seats;
  final String vehicleLocation;
  final String source;
  final String destination;
  final String pickupDateTime;
  final String returnDateTime;
  final String delivery;
  final String purpose;
  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isLoading = true;
        });

        try {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(width: 20.0),
                  Text("Uploading files..."),
                ],
              ),
              duration: Duration(days: 365),
            ),
          );

          await Get.find<FileController>().uploadFiles();

          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          setState(() {
            _isLoading = false;
          });

          // Dismiss the SnackBar
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          showDialog(
              context: context,
              builder: (builder) {
                return AlertDialog(
                  content: SizedBox(
                    width: 300.0,
                    height: 320.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        KycPopUp(
                          seats: widget.seats,
                          vehicleLocation: widget.vehicleLocation,
                          source: widget.source,
                          destination: widget.destination,
                          pickupDateTime: widget.pickupDateTime,
                          returnDateTime: widget.returnDateTime,
                          delivery: widget.delivery,
                          purpose: widget.purpose,
                        ),
                        // Add your dialog content here
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                );
              });
        } catch (e) {
          Fluttertoast.showToast(
            msg: 'Error.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[600],
            textColor: Colors.black,
            fontSize: 16.0,
          );
        }
      },
      child: Container(
        width: 85.0,
        height: 40.0,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
