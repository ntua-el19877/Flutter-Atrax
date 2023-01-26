import 'package:atrax/components/plus_Button.dart';
import 'package:flutter/material.dart';

class HomeDownBar extends StatelessWidget {
  final int currentIndex;
  //height of the homedownbar
  final double preferredSize;
  //if you give screenHeight it moves it to the bottom of the screen
  final double top;
  final double circle_back_Radius;
  final double circle_front_Radius;
  final Color color_Secondary;
  final Color color_Primary;
  final Color color_Blacks;
  final EdgeInsets itemPadding_Left;
  final EdgeInsets itemPadding_Right;
  final Function(int) onTap;
  const HomeDownBar({
    required this.currentIndex,
    required this.preferredSize,
    required this.top,
    this.circle_back_Radius = 30,
    this.circle_front_Radius = 25,
    this.color_Secondary = const Color(0xff929ae7),
    this.color_Primary = const Color(0xffe6f4f1),
    this.color_Blacks = const Color(0xff252525),
    this.itemPadding_Left = const EdgeInsets.only(right: 40),
    this.itemPadding_Right = const EdgeInsets.only(left: 40),
    required this.onTap,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Stack(
        children: <Widget>[
          Positioned(
            top: top - preferredSize,
            left: 0,
            right: 0,
            height: preferredSize,
            child: Container(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0)),
                child: BottomNavigationBar(
                  backgroundColor: color_Secondary,
                  currentIndex: currentIndex,
                  onTap: onTap,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  iconSize: 35,
                  items: [
                    BottomNavigationBarItem(
                        label: 'Home',
                        icon: Container(
                          padding: itemPadding_Left,
                          child: Icon(
                            Icons.people_alt_rounded,
                            size: 35,
                            color: color_Blacks,
                          ),
                        )),
                    BottomNavigationBarItem(
                        label: 'Home',
                        icon: Container(
                          padding: itemPadding_Right,
                          child: Icon(
                            Icons.home,
                            size: 35,
                            color: color_Blacks,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              child: plus_Button(
                  preferredSize: preferredSize,
                  circle_back_Radius: circle_back_Radius,
                  circle_front_Radius: circle_front_Radius,
                  onTap: onTap))
        ],
      );
    });
  }
}
