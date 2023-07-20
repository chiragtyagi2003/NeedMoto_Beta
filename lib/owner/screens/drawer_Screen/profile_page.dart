import 'package:flutter/material.dart';
import '../nav_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(198, 29, 6, 157),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_outlined,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.35,
              width: size.width,
              color: const Color.fromARGB(198, 29, 6, 157),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       IconButton(
                  //         icon: Icon(
                  //           Icons.notifications_none_outlined,
                  //           size: 30,
                  //         ),
                  //         onPressed: () {},
                  //       ),
                  //     ]),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(70)),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.amber,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Harshit Kaushal",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  const Text(
                    "+91 8726558201",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white60),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            _textfeild(
                const Icon(Icons.person_2_outlined), "Rush Wheel", context),
            _textfeild(const Icon(Icons.call_outlined), "9157896545", context),
            _textfeild(
                const Icon(Icons.mail_outline), "selfdrive@gmail.com", context),
            _textfeild(
                const Icon(Icons.date_range_outlined), "10-05-1991", context),
            _textfeild(const Icon(Icons.location_history),
                "6-36/1, Road No. 7 Boduppal,...", context),
            _textfeild(const Icon(Icons.pin_drop_outlined), "500092", context),
            const SizedBox(height: 15),
            _updateButton(context),
            const SizedBox(height: 15),
          ],
        ),
      ),
      // bottomNavigationBar: BottomTab(),
    );
  }

  Widget _textfeild(Icon iconData, String data, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color.fromARGB(95, 0, 0, 0))),
      child: Row(children: [
        Icon(iconData.icon),
        const SizedBox(width: 10),
        Text(
          data,
          style: const TextStyle(fontSize: 20),
        )
      ]),
    );
  }

  Widget _updateButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          )),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(198, 29, 6, 157)),
        ),
        onPressed: () {
          // Get.offAll(() => AddVehicle());
        },
        child: const Center(
          child: Text(
            "Update",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
