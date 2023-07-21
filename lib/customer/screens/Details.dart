import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String title;

  const DetailsPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final text = Text('Details of $title');
    return Scaffold(
      body: Center(child: text),
      appBar: AppBar(title: text),
    );
  }
}
