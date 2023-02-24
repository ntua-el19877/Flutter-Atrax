import 'package:atrax/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'TaskMessage.dart';

class ColumnTaskMessages extends StatefulWidget {
  final Box mybox;
  final Color color_Secondary;
  final Color color_Green;
  final double screenWidth;
  final double TaskLeftPadding;
  late final int currentIndex;
  ColumnTaskMessages({
    required this.mybox,
    required this.color_Secondary,
    required this.color_Green,
    required this.screenWidth,
    required this.TaskLeftPadding,
    required this.currentIndex,
  });

  @override
  _ColumnTaskMessagesState createState() => _ColumnTaskMessagesState();
}

class _ColumnTaskMessagesState extends State<ColumnTaskMessages> {
  @override
  Widget build(BuildContext context) {
    Color _color_TaskMessage = widget.color_Secondary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        ...List.generate(
          widget.mybox.length,
          (index) => Padding(
            padding: EdgeInsets.all(10),
            // child: GestureDetector(
            //   behavior: HitTestBehavior.translucent,
            // onPanUpdate: (details) {
            //   // print(details.delta.dx);
            //   int sensitivity = 1;
            //   // Swiping in right direction.
            //   if (details.delta.dx > sensitivity) {
            //     setState(() {
            //       _color_TaskMessage = widget.color_Green;
            //       print("$_color_TaskMessage");
            //     });
            //   }

            //   // Swiping in left direction.
            //   if (details.delta.dx < -sensitivity) {
            //     setState(() {
            //       _color_TaskMessage = widget.color_Secondary;
            //       print("$_color_TaskMessage");
            //     });
            //   }
            // },
            child: TaskMessage(
              color_Green: color_Green,
              color_Secondary: _color_TaskMessage,
              screen_width: widget.screenWidth,
              name: widget.mybox.getAt(index).name,
              description: widget.mybox.getAt(index).description,
              date: widget.mybox.getAt(index).date,
              time: widget.mybox.getAt(index).time,
              repetitiveness: widget.mybox.getAt(index).repetitiveness,
              notifications: widget.mybox.getAt(index).notifications,
              // notifications_halfOfDay: widget.mybox.getAt(index).description,
              importance: widget.mybox.getAt(index).importance,
              location: widget.mybox.getAt(index).location,
              // longtitude: widget.mybox.getAt(index).location['key2'],
              recording_file_path: widget.mybox.getAt(index).recordingFilePath,
              photo_file_path: widget.mybox.getAt(index).photoFilePath,
              friend_name: widget.mybox.getAt(index).friendName,
              RemoveWidth: 2 * widget.TaskLeftPadding,
              // indexListDate: [
              //   "taskNotificatios_Date.elementAt(0)",
              //   "gres  erw re 1"
              // ],
              // indexListTime: [
              //   "taskNotificatios_Time.elementAt(0)",
              //   " yrew e 1"
              // ],
              onTap: (int index1) {
                setState(() {
                  // readJson();
                  widget.currentIndex = index1;
                });
              },
            ),
          ),
        ),
        // ),
      ],
    );
  }

  @override
  void didUpdateWidget(ColumnTaskMessages oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.mybox.length != oldWidget.mybox.length) {
      setState(() {});
    }
  }

  // void getInfo(int taskNumber) {
  //   Box box = widget.mybox.getAt(taskNumber);

  // }
}
