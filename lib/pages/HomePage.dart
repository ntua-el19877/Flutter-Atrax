import 'package:atrax/components/HomeDownBar.dart';
import 'package:atrax/components/TaskMessage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../services/notifi_service.dart';
import '../components/ColumnTaskMessages.dart';
import '../components/HiveInit.dart';
import '../components/DevButtons.dart';

// // final _contr = TextEditingController();
// List<dynamic> taskNames = [];
// List<String> taskDescriptions = [];
// List<String> taskDates = [];
// List<String> taskTimes = [];
// List<String> taskRepetitiveness = [];
// List<List<String>> taskNotificatios_Date = [];

// List<List<String>> taskNotificatios_Time = [];
// List<String> taskImportance = [];
// List<String> taskLocationLatitude = [];
// List<String> taskLocationLongtitude = [];
// List<String> taskRecording = [];
// List<String> taskPhoto = [];
// List<List<String>> taskFriends = [];

class MainPage extends StatefulWidget {
  final Box box;
  final Box friendbox;

  const MainPage({Key? key, required this.box, required this.friendbox})
      : super(key: key);

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
  // final _mybox = Hive.box('mybox');

  late final ValueListenable<Box> _myBoxListenable;
  int currentIndex = 0;
  double TaskLeftPadding = 10;
  @override
  void initState() {
    super.initState();
    _myBoxListenable = widget.box.listenable();
  }

  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    final _mybox = widget.box;
    final _myfriendsbox = widget.friendbox;
    final screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final bottomNavBarHeight = (screenHeight / 12);
    return Scaffold(
        backgroundColor: const Color(0xffe6f4f1),
        body: Stack(
          children: [
            HomeDownBar(
              box: _mybox,
              friendbox: _myfriendsbox,
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
              friendbox: _myfriendsbox,
              mybox: _mybox,
            ),

            // Use ValueListenableBuilder to rebuild the widget tree
            // whenever the data in _mybox changes
            ValueListenableBuilder(
                valueListenable: _myBoxListenable,
                builder: (context, box, child) {
                  return Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      ElevatedButton(
                        child: const Text('Notification'),
                        onPressed: () {
                          NotificationService().showNotification(
                              title: 'Sample title', body: 'Gaaaay');
                        },
                      ),

                      ColumnTaskMessages(
                        mybox: _mybox,
                        color_Secondary: color_Secondary,
                        color_Green: color_Green,
                        screenWidth: screenWidth,
                        TaskLeftPadding: TaskLeftPadding,
                        currentIndex: currentIndex,
                        maxHeight: 200,
                      )
                      // ),
                    ],
                  ));
                })
          ],
        ));
    // } else {
    //   return Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    // });
  }

  // @override
  // void didUpdateWidget(MainPage oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   // if (_mybox.length != oldWidget._mybox.length) {
  //   setState(() {});
  //   // }
  // }
}
