// import 'package:flutter/material.dart';

// class BottomnavbarV1 extends StatefulWidget {
//   @override
//   BottomnavbarV1State createState() => _BottomnavbarV1State();
// }

// class _MyBottomNavBarState extends State<BottomnavbarV1> {
//   int _selectedIndex = 0;

//   List<Widget> _widgetOptions = <Widget>[    HomeScreen(),    ExploreScreen(),    AccountScreen(),  ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: _selectedIndex,
//       onTap: _onItemTapped,
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.explore),
//           label: 'Explore',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.account_circle),
//           label: 'Account',
//         ),
//       ],
//     );
//   }
// }
