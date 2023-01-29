import 'package:atrax/components/HomeDownBar.dart';
import 'package:atrax/components/TaskMessage.dart';
import 'package:flutter/material.dart';
import 'package:atrax/routes/routes.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<String> taskNames = [];
List<String> taskDescriptions = [];
List<String> taskDates = [];
List<String> taskTimes = [];
List<String> taskHalfOfDays = [];
List<String> taskRepetitiveness = [];
List<List<String>> taskNotificatios_Date = [];
List<List<String>> taskNotificatios_Time = [];
List<String> taskImportance = [];
List<String> taskLocationLatitude = [];
List<String> taskLocationLongtitude = [];
List<String> taskRecording = [];
List<String> taskPhoto = [];
List<List<String>> taskFriends = [];
// Future<void> parseJSON() async {
//    WidgetsFlutterBinding.ensureInitialized();
//   String file = "";
//   switch (type) {
//     case TYPE_STRING:
//       file = 'assets/xml/strings.xml';
//       break;
//   }
//   String jsonString = await File('lib/tasks.json').readAsString();
//   Map<String, dynamic> jsonData = json.decode(jsonString);
//   List<dynamic> tasks = jsonData['tasks'];
//   for (var task in tasks) {
//     taskNames.add(task['name']);
//   }
// }
// // Future<dynamic> readFileAsync(String filePath) async {
// //   String xmlString =  await rootBundle.loadString(filePath);
// //   print(xmlString);
// //   return parseXml(xmlString);
// // }

Future<void> readJson() async {
  final String jsonString = await rootBundle.loadString('assets/tasks.json');
  final data = await json.decode(jsonString);
  // print(data);
  Map<String, dynamic> jsonData = json.decode(jsonString);
  List<dynamic> tasks = jsonData['tasks'];

  taskNames.clear();
  taskDescriptions.clear();
  taskDates.clear();
  // int i = 0;
  for (var task in tasks) {
    List<String> taskNotificationsD = [];
    List<String> taskNotificationsT = [];
    for (var notification in task['notifications']) {
      taskNotificationsD.add(notification['date']);
      taskNotificationsT.add(notification['time']);
    }
    taskNotificatios_Date.add(taskNotificationsD);
    taskNotificatios_Time.add(taskNotificationsT);
  }
  for (var task in tasks) {
    List<String> taskFr = [];
    for (var friend in task['friend_name']) {
      taskFr.add(friend);
    }
    taskFriends.add(taskFr);
  }

  for (var task in tasks) {
    taskNames.add(task['name']);
    taskDescriptions.add(task['description']);
    taskDates.add(task['date']);
    taskTimes.add(task['time']);
    taskHalfOfDays.add(task['halfOfDay']);
    taskRepetitiveness.add(task['repetitiveness']);
    taskRepetitiveness.add(task['repetitiveness']);
    taskImportance.add(task['importance']);
    taskLocationLatitude.add(task['location']['latitude']);
    taskLocationLongtitude.add(task['location']['longitude']);
    taskRecording.add(task['recording_file_path']);
    taskPhoto.add(task['photo_file_path']);
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  double TaskLeftPadding = 10;
  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    readJson();
    final bottomNavBarHeight = (screenHeight / 12);
    return FutureBuilder(
        future: readJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
                          currentIndex = index;
                        });
                      },
                    ),
                    Positioned(
                        left: TaskLeftPadding,
                        top: 40,
                        child: TaskMessage(
                          name: taskNames.elementAt(0),
                          description: taskDescriptions.elementAt(0),
                          date: taskDates.elementAt(0),
                          time: "10:30",
                          halfOfDay: "AM",
                          repetitiveness: "Every Day",
                          notifications_date: ["1-1-1", "2-2-2"],
                          notifications_time: ["11:11", "12:00"],
                          notifications_halfOfDay: ["AM", "PM"],
                          importance: "High",
                          latitude: "latitude",
                          longtitude: "longtitude",
                          recording_file_path: "recording_file_path",
                          photo_file_path: "photo_file_path",
                          friend_name: ["Friend1", "Friend2"],
                          RemoveWidth: 2 * TaskLeftPadding,
                          onTap: (int index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ))
                  ],
                ));
          } else {
            return Container();
          }
        });
  }
}
