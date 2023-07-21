import 'package:flutter/material.dart';

class KycWarning extends StatelessWidget {
  const KycWarning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.red,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child: const Text('* Your documents should be in pdf/jpg/png '
          'and size should not be more than 2mb.'),
    );
  }
}
