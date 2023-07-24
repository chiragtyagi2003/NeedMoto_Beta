import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/screens/profile.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black, // Set the color here
      ),
      backgroundColor: Colors.white,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black, width: 1.0),
          color: Colors.white,
        ),
        width: 200.0,
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            onPressed: () {
              // Handle user button press
              Get.to(ProfilePage());
            },
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
