// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
//
// class AnimatedNotchedBottomBarWidget extends StatefulWidget {
//   final int selectedIndex;
//   final Function(int) onTap;
//
//   AnimatedNotchedBottomBarWidget(
//       {required this.selectedIndex, required this.onTap});
//
//   @override
//   _AnimatedNotchedBottomBarWidgetState createState() =>
//       _AnimatedNotchedBottomBarWidgetState();
// }
//
// class _AnimatedNotchedBottomBarWidgetState
//     extends State<AnimatedNotchedBottomBarWidget> {
//   final _pageController = PageController(initialPage: 0);
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedNotchBottomBar(
//       // currentIndex: widget.selectedIndex,
//       onTap: widget.onTap,
//       notchColor: Colors.white,
//       bottomBarItems: const [
//         BottomBarItem(
//           inActiveItem: Icon(
//             Icons.home_filled,
//             color: Colors.blueGrey,
//           ),
//           activeItem: Icon(
//             Icons.home_filled,
//             color: Colors.blueAccent,
//           ),
//           itemLabel: 'Page 1',
//         ),
//         BottomBarItem(
//           inActiveItem: Icon(
//             Icons.star,
//             color: Colors.blueGrey,
//           ),
//           activeItem: Icon(
//             Icons.star,
//             color: Colors.blueAccent,
//           ),
//           itemLabel: 'Page 2',
//         ),
//         BottomBarItem(
//           inActiveItem: Icon(
//             Icons.settings,
//             color: Colors.blueGrey,
//           ),
//           activeItem: Icon(
//             Icons.settings,
//             color: Colors.pink,
//           ),
//           itemLabel: 'Page 3',
//         ),
//         // BottomBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
//       ],
//       pageController: _pageController,
//     );
//   }
// }
