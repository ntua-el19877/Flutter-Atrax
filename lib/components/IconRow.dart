import 'package:atrax/components/plus_Button.dart';
import 'package:atrax/routes/routes.dart';
import 'package:flutter/material.dart';

class IconRow extends StatefulWidget {
  final List<bool> emptyFields;
  final double iconHeight;
  final double iconRoomHeight;
  final Color color_Blacks;

  IconRow({
    required this.emptyFields,
    this.iconHeight = 22,
    this.iconRoomHeight = 15,
    this.color_Blacks = const Color(0xff252525),
    Key? key,
  }) : super(key: key);

  @override
  _IconRowState createState() => _IconRowState();
}

class _IconRowState extends State<IconRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Row(
      children: [
        if (widget.emptyFields[0])
          SizedBox(
              height: widget.iconRoomHeight,
              child:
                  Icon(Icons.sticky_note_2_outlined, size: widget.iconHeight)),
        if (widget.emptyFields[1])
          SizedBox(
              height: widget.iconRoomHeight,
              child: Icon(Icons.replay, size: widget.iconHeight)),
        if (widget.emptyFields[2])
          SizedBox(
              height: widget.iconRoomHeight,
              child: Icon(Icons.notifications_none_outlined,
                  size: widget.iconHeight)),
        if (widget.emptyFields[3])
          SizedBox(
              height: widget.iconRoomHeight,
              child: Icon(Icons.location_on_outlined, size: widget.iconHeight)),
        if (widget.emptyFields[4])
          SizedBox(
              height: widget.iconRoomHeight,
              child: Icon(Icons.mic_none, size: widget.iconHeight)),
        if (widget.emptyFields[5])
          SizedBox(
              height: widget.iconRoomHeight,
              child:
                  Icon(Icons.insert_photo_outlined, size: widget.iconHeight)),
      ],
    ));
  }
}
