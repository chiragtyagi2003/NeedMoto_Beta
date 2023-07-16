
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:need_moto/customer/screens/customer_side_drawer.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black, // Set the color here
      ),
      backgroundColor: Colors.white,
     /* leading: IconButton(
        icon: Icon(
            Icons.menu,
            color: Colors.black,
        ),
        onPressed: () {
          // Get.to(CustomerSideDrawer());
          // Handle menu button press
        },
      ),*/
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.black,
            width: 1.0
          ),
          color: Colors.white,
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
        width: 200.0,
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            onPressed: () {
              // Handle user button press
            },
          ),
        ),
        SizedBox(width: 5.0,),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
// =======
// import 'package:flutter/material.dart';
//
// class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const MyAppBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.white,
//       leading: IconButton(
//         icon: Icon(
//           Icons.menu,
//           color: Colors.black,
//         ),
//         onPressed: () {
//           // Handle menu button press
//         },
//       ),
//       title: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: Colors.black12, width: 1.0),
//           color: Colors.white,
//         ),
//         child: TextField(
//           decoration: InputDecoration(
//             hintText: 'Search',
//             prefixIcon: Icon(Icons.search),
//             border: InputBorder.none,
//           ),
//         ),
//         width: 320.0,
//         height: 45,
//       ),
//       actions: [
//         CircleAvatar(
//           backgroundColor: Colors.grey.shade300,
//           child: IconButton(
//             icon: Icon(
//               Icons.person,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               // Handle user button press
//             },
//           ),
//         ),
//         SizedBox(
//           width: 5.0,
//         ),
//       ],
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(65);
// }
// >>>>>>> origin/main