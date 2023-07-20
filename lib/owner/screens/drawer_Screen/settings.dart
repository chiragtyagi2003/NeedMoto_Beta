import 'package:flutter/material.dart';

import 'change_password.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "SETTINGS",
            style: TextStyle(color: Colors.black),
          ),
          surfaceTintColor: Colors.black,
          elevation: 1,
        ),
        body: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePassword()));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                child: const Text(
                  "Change Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Divider(
              color: Colors.black45,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
              child: const Text(
                "Language",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              color: Colors.black45,
            ),
          ],
        ));
  }
}
