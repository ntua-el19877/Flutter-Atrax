import 'package:atrax/components/plus_Button.dart';
import 'package:atrax/routes/routes.dart';
import 'package:flutter/material.dart';

class HomeDownBar extends StatefulWidget {
  final int currentIndex;
  final double preferredSize;
  final double top;
  final double circle_back_Radius;
  final double circle_front_Radius;
  final Color color_Secondary;
  final Color color_Primary;
  final Color color_Blacks;
  final EdgeInsets itemPadding_Left;
  final EdgeInsets itemPadding_Right;
  final Function(int) onTap;

  HomeDownBar({
    this.currentIndex = 0,
    required this.preferredSize,
    required this.top,
    this.circle_back_Radius = 30,
    this.circle_front_Radius = 25,
    this.color_Secondary = const Color(0xff929ae7),
    this.color_Primary = const Color(0xffe6f4f1),
    this.color_Blacks = const Color(0xff252525),
    this.itemPadding_Left = const EdgeInsets.only(right: 0),
    this.itemPadding_Right = const EdgeInsets.only(left: 0),
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _HomeDownBarState createState() => _HomeDownBarState();
}

class _HomeDownBarState extends State<HomeDownBar> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: widget.top - widget.preferredSize,
          left: 0,
          right: 0,
          height: widget.preferredSize,
          child: Container(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0)),
              child: BottomNavigationBar(
                backgroundColor: widget.color_Secondary,
                currentIndex: currentIndex,
                onTap: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                  if (index == 0) {
                    Navigator.of(context).pushNamed(RouteManager.friendspage);
                  } else if (index == 1) {
                    Navigator.of(context).pushNamed(RouteManager.calendarpage);
                  }
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                      backgroundColor: Colors.red,
                      label: 'Friends',
                      icon: Container(
                        // alignment: Alignment.centerLeft,
                        padding: widget.itemPadding_Left,
                        child: Icon(
                          Icons.people_alt_rounded,
                          size: 35,
                          color: widget.color_Blacks,
                        ),
                      )),
                  BottomNavigationBarItem(
                      label: 'Calendar',
                      icon: Container(
                        padding: widget.itemPadding_Right,
                        child: Icon(
                          Icons.calendar_month_rounded,
                          size: 35,
                          color: widget.color_Blacks,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            child: plus_Button(
                preferredSize: widget.preferredSize,
                circle_back_Radius: widget.circle_back_Radius,
                circle_front_Radius: widget.circle_front_Radius,
                onTap: widget.onTap))
      ],
    );
  }
}
