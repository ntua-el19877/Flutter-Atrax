import 'package:atrax/components/IconRow.dart';
import 'package:atrax/components/plus_Button.dart';
import 'package:atrax/routes/routes.dart';
import 'package:flutter/material.dart';

class TaskInfo extends StatefulWidget {
  final double RemoveWidth;
  final Color color_Secondary;
  final Color color_Primary;
  final Color color_Blacks;
  final Color color_Red;

  final String name;
  final String description;
  final String date;
  final String time;
  final String halfOfDay;
  final String repetitiveness;
  final List<String> notifications_date;
  final List<String> notifications_time;
  final List<String> notifications_halfOfDay;
  final String importance;
  final String latitude;
  final String longtitude;
  final String recording_file_path;
  final String photo_file_path;
  final List<String> friend_name;
  final Function(int) onTap;

  TaskInfo({
    this.RemoveWidth = 0,
    this.color_Secondary = const Color(0xff929ae7),
    this.color_Primary = const Color(0xffe6f4f1),
    this.color_Blacks = const Color(0xff252525),
    this.color_Red = const Color(0xffae4e54),
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.halfOfDay,
    required this.repetitiveness,
    required this.notifications_date,
    required this.notifications_time,
    required this.notifications_halfOfDay,
    required this.importance,
    required this.latitude,
    required this.longtitude,
    required this.recording_file_path,
    required this.photo_file_path,
    required this.friend_name,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _TaskInfoState createState() => _TaskInfoState();
}

class _TaskInfoState extends State<TaskInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.color_Blacks,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Stack(
            children: [
              // Add your widgets here
            ],
          ),
        ));
  }
}
