// import 'package:flutter/material.dart';

// class CustomBottomNavigationBar extends StatelessWidget {
//   final int selectedIndex;
//   final void Function(int) onItemTapped;

//   const CustomBottomNavigationBar({
//     required this.selectedIndex,
//     required this.onItemTapped,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Accueil',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.monetization_on),
//           label: 'Calculatrice',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.add),
//           label: 'Ajouter',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.history),
//           label: 'Historique',
//         ),
//       ],
//       currentIndex: selectedIndex,
//       selectedItemColor: Colors.green,
//       unselectedItemColor: Colors.black,
//       onTap: onItemTapped,
//     );
//   }
// }
