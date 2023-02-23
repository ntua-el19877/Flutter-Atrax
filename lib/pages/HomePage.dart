import 'package:atrax/components/HomeDownBar.dart';
import 'package:atrax/components/TaskMessage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../components/ColumnTaskMessages.dart';
import '../components/HiveInit.dart';
import '../components/DevButtons.dart';

// final _contr = TextEditingController();
List<dynamic> taskNames = [];
List<String> taskDescriptions = [];
List<String> taskDates = [];
List<String> taskTimes = [];
List<String> taskRepetitiveness = [];
List<List<String>> taskNotificatios_Date = [];

List<List<String>> taskNotificatios_Time = [];
List<String> taskImportance = [];
List<String> taskLocationLatitude = [];
List<String> taskLocationLongtitude = [];
List<String> taskRecording = [];
List<String> taskPhoto = [];
List<List<String>> taskFriends = [];

class MainPage extends StatefulWidget {
  final Box box;

  const MainPage({Key? key, required this.box}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

Color _color_TaskMessage = color_Secondary;
const Color color_Secondary = Color(0xff929ae7);
const Color color_Primary = Color(0xffe6f4f1);
const Color color_Blacks = Color(0xff252525);
const Color color_Red = Color(0xffa54e54);
const Color color_Green = Color(0xff1f8a87);

class _MainPageState extends State<MainPage> {
  final _mybox = Hive.box('mybox');

  int currentIndex = 0;
  double TaskLeftPadding = 10;
  @override
  void initState() {
    super.initState();
  }

  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    final _mybox = widget.box;
    final screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final bottomNavBarHeight = (screenHeight / 12);
    // return FutureBuilder(
    //     // future: readJson(),
    //     builder: (context, snapshot) {
    //   if (snapshot.connectionState == ConnectionState.done) {
    return Scaffold(
        backgroundColor: const Color(0xffe6f4f1),
        body: Stack(
          children: [
            HomeDownBar(
              currentIndex: currentIndex,
              top: screenHeight,
              circle_front_Radius: 35,
              circle_back_Radius: 40,
              preferredSize: bottomNavBarHeight,
              onTap: (int index) {
                setState(() {
                  // readJson();
                  currentIndex = index;
                });
              },
            ),
            DevButtons(
              mybox: _mybox,
            ),
            Center(
                child: Column(
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
                          _color_TaskMessage = color_Green;
                        });
                      }

                      // Swiping in left direction.
                      if (details.delta.dx < -sensitivity) {
                        setState(() {
                          _color_TaskMessage = color_Secondary;
                        });
                      }
                    },
                    // child: Positioned(
                    //   left: TaskLeftPadding,
                    //   top: 40,
                    child: TaskMessage(
                      color_Secondary: _color_TaskMessage,
                      screen_width: screenWidth,
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
                      RemoveWidth: 2 * TaskLeftPadding,
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
                          currentIndex = index1;
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
                          _color_TaskMessage = color_Green;
                        });
                      }

                      // Swiping in left direction.
                      if (details.delta.dx < -sensitivity) {
                        setState(() {
                          _color_TaskMessage = color_Secondary;
                        });
                      }
                    },
                    // child: Positioned(
                    // left: TaskLeftPadding,
                    // top: 40,
                    child: TaskMessage(
                      color_Secondary: _color_TaskMessage,
                      screen_width: screenWidth,
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
                      RemoveWidth: 2 * TaskLeftPadding,
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
                          currentIndex = index1;
                        });
                      },
                    ),
                  ),
                ),
                // ),
              ],
            )

                // ColumnTaskMessages(
                // color_Secondary: color_Secondary,
                // mybox: _mybox,
                // color_Green: color_Green,
                // screenWidth: screenWidth,
                // TaskLeftPadding: TaskLeftPadding,
                // currentIndex: currentIndex,
                )
          ],
        ));
    // } else {
    //   return Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    // });
  }
}
