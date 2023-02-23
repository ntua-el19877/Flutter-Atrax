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
        Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onPanUpdate: (details) {
              int sensitivity = 10;
              // Swiping in right direction.
              if (details.delta.dx > sensitivity) {
                setState(() {
                  _color_TaskMessage = widget.color_Green;
                });
              }

              // Swiping in left direction.
              if (details.delta.dx < -sensitivity) {
                setState(() {
                  _color_TaskMessage = widget.color_Secondary;
                });
              }
            },
            // child: Positioned(
            //   left: TaskLeftPadding,
            //   top: 40,
            child: TaskMessage(
              color_Secondary: _color_TaskMessage,
              screen_width: widget.screenWidth,
              name: "taskNames.elementAt(0)",
              description:
                  "taskDescriptions.elementAt(0) ith this code, the Column widget will expand vertically if the widget.text is too big to fit in the available space. The Flexible widget is wrapped around the Column widget to allow it to grow vertically. The fit property of the Flexible widget is set to FlexFit.loose to indicate that the Column widget should grow only as much as necessary to fit its children.",
              date: "taskDates.elementAt(0)",
              time: "10:30 AM",
              repetitiveness: "Every Day",
              notifications_date: ["1-1-1", "2-2-2"],
              notifications_time: ["11:11", "12:00"],
              notifications_halfOfDay: ["AM", "PM"],
              importance: "High",
              latitude: "taskLocationLatitude.elementAt(0)",
              longtitude: "taskLocationLongtitude.elementAt(0)",
              recording_file_path: 'assets/recordings/Scoobydoo.mp3',
              photo_file_path: "photo_file_path",
              friend_name: ["Friend1", "Friend2"],
              RemoveWidth: 2 * widget.TaskLeftPadding,
              indexListDate: [
                "taskNotificatios_Date.elementAt(0)",
                "gres  erw re 1"
              ],
              indexListTime: [
                "taskNotificatios_Time.elementAt(0)",
                " yrew e 1"
              ],
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
        Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onPanUpdate: (details) {
              int sensitivity = 10;
              // Swiping in right direction.
              if (details.delta.dx > sensitivity) {
                setState(() {
                  _color_TaskMessage = widget.color_Green;
                });
              }

              // Swiping in left direction.
              if (details.delta.dx < -sensitivity) {
                setState(() {
                  _color_TaskMessage = widget.color_Secondary;
                });
              }
            },
            // child: Positioned(
            // left: TaskLeftPadding,
            // top: 40,
            child: TaskMessage(
              color_Secondary: _color_TaskMessage,
              screen_width: widget.screenWidth,
              name: "taskNames.elementAt(0)",
              description:
                  "taskDescriptions.elementAt(0) ith this code, the Column widget will expand vertically if the widget.text is too big to fit in the available space. The Flexible widget is wrapped around the Column widget to allow it to grow vertically. The fit property of the Flexible widget is set to FlexFit.loose to indicate that the Column widget should grow only as much as necessary to fit its children.",
              date: "taskDates.elementAt(0)",
              time: "10:30 AM",
              repetitiveness: "Every Day",
              notifications_date: ["1-1-1", "2-2-2"],
              notifications_time: ["11:11", "12:00"],
              notifications_halfOfDay: ["AM", "PM"],
              importance: "High",
              latitude: "taskLocationLatitude.elementAt(0)",
              longtitude: "taskLocationLongtitude.elementAt(0)",
              recording_file_path: 'assets/recordings/Scoobydoo.mp3',
              photo_file_path: "photo_file_path",
              friend_name: ["Friend1", "Friend2"],
              RemoveWidth: 2 * widget.TaskLeftPadding,
              indexListDate: [
                "taskNotificatios_Date.elementAt(0)",
                "gres  erw re 1"
              ],
              indexListTime: [
                "taskNotificatios_Time.elementAt(0)",
                " yrew e 1"
              ],
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
}
