import 'package:atrax/components/HomeDownBar.dart';
import 'package:atrax/components/TaskMessage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

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
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Future<void> readJson() async {
  //   try {
  //     // your existing code here

  //     List _items = [];
  //     final String jsonString =
  //         await rootBundle.loadString('assets/tasks.json');
  //     final data = await json.decode(jsonString);
  //     // print(data);
  //     Map<String, dynamic> jsonData = json.decode(jsonString);
  //     List<dynamic> tasks = jsonData['tasks'];

  //     // setState(() {
  //     //   _items = data["tasks"];
  //     // });
  //     taskNames.clear();
  //     taskDescriptions.clear();
  //     taskDates.clear();
  //     taskNotificatios_Date.clear();
  //     taskNotificatios_Time.clear();
  //     taskTimes.clear();
  //     taskRepetitiveness.clear();
  //     taskImportance.clear();
  //     taskLocationLatitude.clear();
  //     taskLocationLongtitude.clear();
  //     taskRecording.clear();
  //     taskPhoto.clear();
  //     // int i = 0;
  //     for (var task in tasks) {
  //       List<String> taskNotificationsD = [];
  //       List<String> taskNotificationsT = [];
  //       for (var notification in task['notifications']) {
  //         taskNotificationsD.add(notification['date']);
  //         taskNotificationsT.add(notification['time']);
  //       }
  //       taskNotificatios_Date.add(taskNotificationsD);
  //       taskNotificatios_Time.add(taskNotificationsT);
  //     }
  //     for (var task in tasks) {
  //       List<String> taskFr = [];
  //       for (var friend in task['friend_name']) {
  //         taskFr.add(friend);
  //       }
  //       taskFriends.add(taskFr);
  //     }

  //     for (var task in tasks) {
  //       taskNames.add(task['name']);
  //       taskDescriptions.add(task['description']);
  //       taskDates.add(task['date']);
  //       taskTimes.add(task['time']);
  //       taskRepetitiveness.add(task['repetitiveness']);
  //       //taskRepetitiveness.add(task['repetitiveness']);
  //       taskImportance.add(task['importance']);
  //       taskLocationLatitude.add(task['location']['latitude']);
  //       taskLocationLongtitude.add(task['location']['longitude']);
  //       taskRecording.add(task['recording_file_path']);
  //       taskPhoto.add(task['photo_file_path']);
  //     }
  //     // hhh = taskNames.elementAt(0);
  //     print('----------------------');
  //     for (int i = 0; i < taskNames.length; i++) {
  //       print(taskNames.elementAt(i));
  //     }
  //     print("-----------------");
  //   } catch (e) {
  //     print('An error occurred while reading the JSON file: $e');
  //   }
  // }
  //reference my box
  final _mybox=Hive.box('mybox');
  //void writeData() {_my}
  void readData(){}
  int currentIndex = 0;
  double TaskLeftPadding = 10;
  @override
  void initState() {
    super.initState();
    // readJson();
  }

  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
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
            Positioned(
                child: ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )),
            Positioned(
                left: TaskLeftPadding,
                top: 40,
                child: TaskMessage(
                  screen_width: screenWidth,
                  name: "taskNames.elementAt(0)",
                  description: "taskDescriptions.elementAt(0)",
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
                  indexListDate: ["taskNotificatios_Date.elementAt(0)", "1"],
                  indexListTime: ["taskNotificatios_Time.elementAt(0)", "1"],
                  onTap: (int index1) {
                    setState(() {
                      // readJson();
                      currentIndex = index1;
                    });
                  },
                ))
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
