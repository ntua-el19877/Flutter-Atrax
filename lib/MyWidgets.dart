import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  /*int currentIndex = 0;
  void onTap(int index){
    currentIndex = index;
  }
  */
  const BottomNavbar({
    required this.currentIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation :0,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Favorites',
          icon: Icon(Icons.favorite),
        ),
        BottomNavigationBarItem(
          label: 'Settings',
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
