import 'package:flutter/material.dart';

class plus_Button extends StatefulWidget {
  //height of the homedownbar
  final double preferredSize;
  //if you give screenHeight it moves it to the bottom of the screen
  final double circle_back_Radius;
  late double circle_front_Radius;
  final Color color_Secondary;
  final Color color_Primary;
  final Color color_Blacks;
  final Function(int) onTap;

  plus_Button({
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
  _plus_ButtonState createState() => _plus_ButtonState();
}

class _plus_ButtonState extends State<plus_Button> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Stack(
        children: <Widget>[
          Positioned(
            left: constraints.maxWidth / 2 - widget.circle_back_Radius,
            bottom: widget.preferredSize - widget.circle_back_Radius,
            child: CircleAvatar(
              radius: widget.circle_back_Radius,
              backgroundColor: widget.color_Primary,
            ),
          ),
          Positioned(
            left: constraints.maxWidth / 2 - widget.circle_front_Radius,
            bottom: widget.preferredSize - widget.circle_front_Radius,
            child: InkWell(
              onHover: (isHovering) {
                setState(() {
                  if (isHovering) {
                    widget.circle_front_Radius = 30;
                  } else {
                    widget.circle_front_Radius = 25;
                  }
                });
              },
              child: CircleAvatar(
                radius: widget.circle_front_Radius,
                backgroundColor: widget.color_Secondary,
                child: Icon(
                  Icons.add,
                  size: 35,
                  color: widget.color_Blacks,
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
