import 'package:flutter/material.dart';

class plus_Button extends StatelessWidget {
  //height of the homedownbar
  final double preferredSize;
  //if you give screenHeight it moves it to the bottom of the screen
  final double circle_back_Radius;
  final double circle_front_Radius;
  final Color color_Secondary;
  final Color color_Primary;
  final Color color_Blacks;
  final Function(int) onTap;

  const plus_Button({
    required this.preferredSize,
    this.circle_back_Radius = 30,
    this.circle_front_Radius = 25,
    this.color_Secondary = const Color(0xff929ae7),
    this.color_Primary = const Color(0xffe6f4f1),
    this.color_Blacks = const Color(0xff252525),
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
            left: constraints.maxWidth / 2 - circle_back_Radius,
            bottom: preferredSize - circle_back_Radius,
            child: CircleAvatar(
              radius: circle_back_Radius,
              backgroundColor: color_Primary,
            ),
          ),
          Positioned(
            left: constraints.maxWidth / 2 - circle_front_Radius,
            bottom: preferredSize - circle_front_Radius,
            child: CircleAvatar(
              radius: circle_front_Radius,
              backgroundColor: color_Secondary,
              child: Icon(
                Icons.add,
                size: 35,
                color: color_Blacks,
              ),
            ),
          )
        ],
      );
    });
  }
}
