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
    List<TaskMessage> taskMessages = List.generate(
      widget.mybox.length,
      (index) => TaskMessage(
        color_Green: color_Green,
        color_Secondary: _color_TaskMessage,
        screen_width: widget.screenWidth,
        name: widget.mybox.getAt(index).name,
        description: widget.mybox.getAt(index).description,
        date: widget.mybox.getAt(index).date,
        time: widget.mybox.getAt(index).time,
        repetitiveness: widget.mybox.getAt(index).repetitiveness,
        notifications: widget.mybox.getAt(index).notifications,
        importance: widget.mybox.getAt(index).importance,
        location: widget.mybox.getAt(index).location,
        recording_file_path: widget.mybox.getAt(index).recordingFilePath,
        photo_file_path: widget.mybox.getAt(index).photoFilePath,
        friend_name: widget.mybox.getAt(index).friendName,
        RemoveWidth: 2 * widget.TaskLeftPadding,
        onTap: (int index1) {
          setState(() {
            print("yes");
            widget.currentIndex = index1;
          });
        },
      ),
    );
// Sort the taskMessages list based on date and time
    taskMessages.sort((a, b) {
      // Compare the dates first
      int dateComparison = a.date.compareTo(b.date);
      if (dateComparison != 0) {
        return dateComparison;
      }

      // If the dates are the same, compare the times
      return a.time.compareTo(b.time);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        ...taskMessages.map((taskMessage) => Padding(
              padding: const EdgeInsets.all(10),
              child: taskMessage,
            )),
      ],
    );
  }

  @override
  void didUpdateWidget(ColumnTaskMessages oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.mybox.length != oldWidget.mybox.length) {
      setState(() {});
      // List values = widget.mybox.values.toList();
      // values.sort((a, b) => a.date.compareTo(b.date));
    }
  }

  // void getInfo(int taskNumber) {
  //   Box box = widget.mybox.getAt(taskNumber);

  // }
}
