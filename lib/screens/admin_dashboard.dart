import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  final brandNameController = TextEditingController();
  final averageController = TextEditingController();

  void submitForm() {
    final brandName = brandNameController.text;
    final average = double.tryParse(averageController.text) ?? 0;

    // Perform actions with the form data
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: brandNameController,
              decoration: InputDecoration(
                labelText: 'Brand Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: averageController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Average',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
