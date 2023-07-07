import 'package:flutter/material.dart';
import 'package:need_moto/customer/screens/Details.dart';


class Page extends StatelessWidget {
  final String title;

  const Page(this.title) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    final text = Text(title);

    return Scaffold(
      body: Container(
        child: Center(
            child: ElevatedButton(
                onPressed: () => _openDetailsPage(context), child: text)),
      ),
      appBar: AppBar(
        title: text,
      ),
    );
  }

  //Use the navigator like you usually do with .of(context) method
  _openDetailsPage(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => DetailsPage(title)));

//  _openDetailsPage(BuildContext context) => mainNavigatorKey.currentState.push(MaterialPageRoute(builder: (context) => DetailsPage(title)));
}
