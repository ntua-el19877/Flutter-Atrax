import 'dart:html';

import 'package:flutter/material.dart';

class CustomRectangle extends StatefulWidget {
  final IconData myIcon;
  final double myIconSize;
  final Color myIconColor;
  final bool myIconEnabled;
  final Color color_Back;
  final double Rad;
  final double width;
  final String text;
  final String title;
  final TextAlign textAlign;
  final TextAlign titleAlign;
  final double rect_padding;
  final double titleSize;
  final double textSize;
  final Color color_Blacks;
  final Color color_Title;

  CustomRectangle({
    this.myIconSize = 20,
    this.myIconColor = Colors.red,
    this.myIconEnabled = false,
    this.myIcon = Icons.disabled_by_default_outlined,
    this.color_Back = const Color(0xffd9d9d9),
    this.Rad = 5,
    required this.width,
    required this.text,
    required this.title,
    this.titleSize = 20,
    this.textSize = 15,
    this.color_Blacks = const Color(0xff252525),
    this.color_Title = const Color(0xff8b8db9),
    this.rect_padding = 5,
    this.textAlign = TextAlign.center,
    this.titleAlign = TextAlign.left,
  });

  @override
  _CustomRectangleState createState() => _CustomRectangleState();
}

class _CustomRectangleState extends State<CustomRectangle> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.Rad),
          topRight: Radius.circular(widget.Rad),
          bottomLeft: Radius.circular(widget.Rad),
          bottomRight: Radius.circular(widget.Rad)),
      child: Container(
        width: widget.width,
        color: widget.color_Back,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.myIconEnabled)
              SizedBox(
                width: widget.width / 8,
                child: Icon(
                  widget.myIcon,
                  color: widget.myIconColor,
                  size: widget.myIconSize,
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: widget.titleSize,
                      fontWeight: FontWeight.bold,
                      color: widget.color_Title,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: widget.rect_padding),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: widget.textSize,
                      fontWeight: FontWeight.bold,
                      color: widget.color_Blacks,
                    ),
                  ),
                )
              ],
            ),
            if (widget.myIconEnabled)
              Container(
                width: widget.width / 8,
              ),
          ],
        ),
      ),
    );
  }
}
