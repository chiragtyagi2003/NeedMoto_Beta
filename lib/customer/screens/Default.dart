import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/screens/backup.dart';


class HomePagetest extends StatelessWidget {
  final List<Widget> pages = [
    HomePage(),
    Page1(),
    Page2(),
    Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: pages[Get.find<BottomNavController>().selectedIndex.value],
          ),
          Obx(
            () => BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book), label: 'Page 1'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.movie), label: 'Page 2'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.music_note), label: 'Page 3'),
              ],
              currentIndex: Get.find<BottomNavController>().selectedIndex.value,
              onTap: (int index) {
                if (index !=
                    Get.find<BottomNavController>().selectedIndex.value) {
                  Get.find<BottomNavController>().selectedIndex.value = index;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Page 5'),
          onPressed: () {
            Get.to(Page5());
          },
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(
        child: Text('Page 2'),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 3'),
      ),
      body: Center(
        child: Text('Page 3'),
      ),
    );
  }
}

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 5'),
      ),
      body: Center(
        child: Text('Page 5'),
      ),
    );
  }
}
