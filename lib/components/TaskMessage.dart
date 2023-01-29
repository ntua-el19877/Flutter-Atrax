import 'package:atrax/components/IconRow.dart';
import 'package:atrax/components/plus_Button.dart';
import 'package:atrax/routes/routes.dart';
import 'package:flutter/material.dart';

class TaskMessage extends StatefulWidget {
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

  TaskMessage({
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
  _TaskMessageState createState() => _TaskMessageState();
}

class _TaskMessageState extends State<TaskMessage> {
  late List<bool> emptyFields;
  void check() {
    emptyFields = [true, true, true, true, true, true];

    if (widget.description == "") emptyFields[0] = false;
    if (widget.repetitiveness == "") emptyFields[1] = false;
    if (widget.notifications_date.isEmpty) emptyFields[2] = false;
    if (widget.latitude == "") emptyFields[3] = false;
    if (widget.recording_file_path == "") emptyFields[4] = false;
    if (widget.photo_file_path == "") emptyFields[5] = false;
  }

  @override
  Widget build(BuildContext context) {
    check();
    double iconHeight = 22;
    double iconRoomHeight = 15;
    return GestureDetector(
      // onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - widget.RemoveWidth,
        height: 60,
        decoration: BoxDecoration(
          color: widget.color_Secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5, top: 0),
                    child: Icon(
                      Icons.check_box_outline_blank,
                      color: widget.color_Blacks,
                      size: 20,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: widget.color_Blacks,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 5,
                                child: Text(
                                  "${widget.time} ${widget.halfOfDay}",
                                  style: TextStyle(
                                    color: widget.color_Blacks,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: iconRoomHeight, width: 10),
                                    SizedBox(
                                      height: iconRoomHeight,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: Text(
                                        widget.date,
                                        style: TextStyle(
                                          color: widget.color_Blacks,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconRow(
                                      emptyFields: emptyFields,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
