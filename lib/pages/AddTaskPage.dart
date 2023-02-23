import 'dart:convert';
import 'dart:math';

import 'package:atrax/entities/AddTaskJSON.dart';
import 'package:atrax/file_manager.dart';
import 'package:hive/hive.dart';
import '../routes/routes.dart';
import '../GoogleMap.dart';

import 'package:flutter/material.dart';
//import 'package:atrax/entities/TaskJSON.dart';

import 'package:geolocator/geolocator.dart';

// <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />;

import '../components/HiveInit.dart' as HiveInit;

class Notification {
  String date;
  String time;

  Notification(this.date, this.time);

  Map toJson() => {
        'date': date,
        'time': time,
      };
}

class AddTaskPage extends StatefulWidget {
  final Box box;
  final Box friendbox;

  const AddTaskPage({Key? key, required this.box, required this.friendbox})
      : super(key: key);
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  var _TaskController = TextEditingController(); /*  task controller  */
  final _DescriptionController =
      TextEditingController(); /*  description controller  */

  /*DateTime due_date = DateTime.now();   */
  DateTime due_date = DateUtils.dateOnly(DateTime.now());
  var DueDate = ''; /*  user due date  */

  TimeOfDay due_time = TimeOfDay(hour: 8, minute: 00);
  var DueTime = ''; /*  user due time  */

  var repetitiveness = '';

  var importance = '';

  var lat = ''; /*  GPS variables  */
  var long = '';

  TimeOfDay notification_time = TimeOfDay(hour: 8, minute: 00);
  DateTime notification_date = DateUtils.dateOnly(DateTime.now());
  var NotDate = '';
  var NotTime = '';
  final List<String> Notifications_Day_and_Time = ['', ''];
  int list_counter = 0; /* number of notifications */
  var Notifications_List = List.generate(10, (i) => ['', ''], growable: true);
  var new_Notifications_List =
      List.generate(10, (i) => Notification('', ''), growable: true);
  var jsonNotifications;

  String task = ''; /*  user task   */
  String description = ''; /*  user description   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*
      appBar: AppBar(
        title: const Text('Add Task Page'),
      ),
      */
        backgroundColor: const Color(0xffE6F4F1),
        body: Column(
          children: [
            const SizedBox(height: 100),
            /*    TASK NAME AND DESCRIPTION INPUTS   */
            Container(
              width: MediaQuery.of(context).size.width,
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xff929AE7),
                border: Border.all(color: const Color(0xff929AE7)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Task name : ',
                    style: TextStyle(fontSize: 21),
                  ),
                  TextField(
                      controller: _TaskController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      )),
                  const Text(
                    'Description : ',
                    style: TextStyle(fontSize: 21),
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                              controller: _DescriptionController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(width: 2)),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.all(20),
                                isDense: true,
                                hintText: 'Enter a description',
                                hintStyle: TextStyle(fontSize: 18),
                                alignLabelWithHint: true,
                              )))),
                ],
              ),
            ),

            /*    ROW WITH ICON BUTTONS     */

            Container(
              color: Color(0xffff929AE7),
              child: Row(
                children: [
                  TextButton(
                    //child: Text("Calendar"),
                    child: const Icon(Icons.date_range_rounded,
                        color: Color(0xff252525)),
                    onPressed: openDatePicker,
                  ),
                  TextButton(
                    //child: Text("Clock"),
                    child:
                        const Icon(Icons.access_time, color: Color(0xff252525)),
                    onPressed: openTimePicker,
                  ),
                  TextButton(
                    //child: Text("Repeat"),
                    child: const Icon(Icons.replay, color: Color(0xff252525)),
                    onPressed: openRepetitiveness,
                  ),
                  TextButton(
                    child: const Icon(Icons.notifications_none_outlined,
                        color: Color(0xff252525)),
                    onPressed: openNotificationWindow,
                  ),
                  TextButton(
                    child: const Icon(Icons.outlined_flag,
                        color: Color(0xff252525)),
                    onPressed: openImportanceWindow,
                  ),
                  TextButton(
                      child: const Icon(Icons.location_on_outlined,
                          color: Color(0xff252525)),
                      onPressed: () {
                        openLocationWindow().then((value) {
                          lat = '${value.latitude}';
                          long = '${value.longitude}';
                          MapUtils.openMap(lat, long);
                        });
                      }),
                ],
              ),
            ),

            /*   CONFIRM BUTTONS  */
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xff929AE7),
                border: Border.all(color: Color(0xff929AE7)),
              ),
              child: Row(
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff06661B), // Background color
                    ),
                    child: Text('Confirm'),
                    onPressed: _SaveTask,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffA32F7D), // Background color
                    ),
                    child: Text('Invite a friend'),
                    onPressed: _SaveTask,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Close Second Page"),
                  )
                ],
              ),
            ),

            /*    SAVED PARAMETERS WINDOW   */
            Container(
              color: Colors.green,
              child: Column(children: [
                Text("USER'S INPUTS"),
                Text("Task name :"),
                Text(task),
                Text("Task Decription :"),
                Text(description),
                Text("Due date"),
                Text(DueDate),
                Text("Due time"),
                Text(DueTime),
                Text("Your Location :"),
                Text(long + " " '$lat')
              ]),
            ),
          ],
        ));
  }

  String generateRandomString() {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random.secure();
    return List.generate(9, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  void _SaveTask() async {
    // setState(() {
    //   task = _TaskController.text;
    //   description = _DescriptionController.text;
    //   jsonNotifications = jsonEncode(new_Notifications_List); //TYPE JSON MAP //
    //   debugPrint(jsonNotifications);
    // });
    HiveInit.Task task2 = HiveInit.Task(
      name: _TaskController.text,
      description: _DescriptionController.text,
      date: DueDate,
      time: DueTime,
      repetitiveness: repetitiveness,
      notifications: widget.box.getAt(0).notifications,
      importance: importance,
      location: 'latitude' + '37.7749' + 'longitude' + '-122.4194',
      recordingFilePath: '/path/to/recording',
      photoFilePath: '/path/to/photo',
      friendName: ['John', 'Jane'],
    );
    // final _mytask = _mybox.get('mytask');
    widget.box.put(generateRandomString(), task2);

    final rawData = <String, dynamic>{
      'name': task,
      'description': description,
      'date': DueDate,
      'time': DueTime,
      'repetitiveness': repetitiveness,
      'notifications': new_Notifications_List,
      'importance': importance,
      'location': Location(latitude: 1, longitude: 7),
      'recordingFilePath': 'path1',
      'photoFilePath': 'path2',
      'friendName': ["julie", "jess"]
    };
    await AddTaskData.saveJsonData(rawData);
    AddTaskData.getJsonData();
    AddTaskData.parseJson(rawData);
    //FileManager().writeJsonFile(rawData);
  }

  void openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        due_date = value!;
        DueDate = "${due_date.day}-${due_date.month}-${due_date.year}";
      });
    });
  }

  void openTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        due_time = value!;
        DueTime = due_time.format(context).toString();
      });
    });
  }

  Future openRepetitiveness() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("Select task's repetitiveness"),
          content: Column(children: [
            Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      child: Text("Does Not Repeat"),
                      onPressed: () => setState(() {
                            repetitiveness = 'does not repeat';
                            Navigator.of(context).pop();
                          })),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      child: Text("Every Day"),
                      onPressed: () => setState(() {
                            repetitiveness = 'every day';
                            Navigator.of(context).pop();
                          })),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      child: Text("Every Week"),
                      onPressed: () => setState(() {
                            repetitiveness = 'every week';
                            Navigator.of(context).pop();
                          })),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      child: Text("Every Month"),
                      onPressed: () => setState(() {
                            repetitiveness = 'every month';
                            Navigator.of(context).pop();
                          })),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      child: Text("Cancel"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrangeAccent,
                      ),
                      onPressed: () => setState(() {
                            Navigator.of(context).pop();
                          })),
                ),
              ],
            ),
          ])));

  Future openNotificationWindow() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Add a notification"),
          content: Container(
            child: Column(children: [
              Row(
                children: [
                  ElevatedButton(
                      child: Text("Select day"),
                      onPressed: openNotificationDay),
                  ElevatedButton(
                      child: Text("Select time"),
                      onPressed: openNotificationTime),
                ],
              ),
              Row(
                children: [
                  const Text('Your notification date and time : '),
                  /*Text(NotDate),
                const Text(" "),
                Text(NotTime), */
                ],
              ),
              for (var i = 0; i < list_counter; i++)
                getCardWidgets(Notifications_List[i]),
              AddNotificationsButtons()
            ]),
          ),
        ),
      );

  Widget getCardWidgets(List<String> strings) {
    List<Widget> list = [];
    for (var i = 0; i < 1; i++) {
      list.add(Container(
        width: 250,
        //color: Color(0xff929AE7),
        child: Card(
            color: Color(0xff929AE7),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(strings[0]),
                    Text(" "),
                    Text(strings[1]),
                  ],
                ))),
      ));
    }
    return new Row(children: list);
  }

  Widget AddNotificationsButtons() {
    List<Widget> list = [];
    if (list_counter == 0) {
      list.add(Container(
          child: ElevatedButton(
        child: Text("Cancel"),
        style: ElevatedButton.styleFrom(
          primary: Colors.deepOrangeAccent,
          //onPrimary: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            list_counter = 0;
            Notifications_List =
                List.generate(10, (i) => ['', ''], growable: true);
            new_Notifications_List =
                List.generate(10, (i) => Notification('', ''), growable: true);
            debugPrint('${(Notifications_List.toString())}');
          });
        },
      )));
    }
    if (list_counter != 0) {
      list.add(Container(
          child: Column(children: [
        ElevatedButton(
          child: Text(" Save Notifications "),
          style: ElevatedButton.styleFrom(
            primary: Color(0xff06661B),
            //onPrimary: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: Text("Delete Notifications"),
          style: ElevatedButton.styleFrom(
            primary: Colors.deepOrangeAccent,
            //onPrimary: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              list_counter = 0;
              Notifications_List =
                  List.generate(10, (i) => ['', ''], growable: true);
              new_Notifications_List = List.generate(
                  10, (i) => Notification('', ''),
                  growable: true);
              debugPrint('${(Notifications_List.toString())}');
            });
          },
        )
      ])));
    }
    return Row(children: list);
  }

  void openNotificationDay() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        notification_date = value!;

        NotDate =
            "${notification_date.day}-${notification_date.month}-${notification_date.year}";
        Notifications_Day_and_Time[0] = NotDate;
        Notifications_List[list_counter][0] = NotDate;
        new_Notifications_List[list_counter] = Notification(NotDate, NotTime);
        if (Notifications_List[list_counter][1] != '') {
          list_counter = list_counter + 1;
        }
        debugPrint('${(Notifications_List.toString())}');
        Navigator.pop(context);
        openNotificationWindow();
      });
    });
  }

  void openNotificationTime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        notification_time = value!;
        NotTime = notification_time.format(context).toString();
        Notifications_Day_and_Time[1] = NotTime;
        Notifications_List[list_counter][1] = NotTime;
        new_Notifications_List[list_counter] = Notification(NotDate, NotTime);
        if (Notifications_List[list_counter][0] != '') {
          list_counter = list_counter + 1;
        }
        debugPrint('${(Notifications_List.toString())}');
        Navigator.pop(context);
        openNotificationWindow();
      });
    });
  }

  void openImportanceWindow() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("Select task's importance"),
          content: Container(
              child: Row(
            children: [
              ElevatedButton(
                child: Text("Low"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff9787D7)),
                onPressed: () {
                  setState(() {
                    importance = 'Low';
                    Navigator.of(context).pop();
                  });
                },
              ),
              SizedBox(width: 20),
              ElevatedButton(
                child: Text("Mid"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffA15EAF)),
                onPressed: () {
                  setState(() {
                    importance = 'Mid';
                    Navigator.of(context).pop();
                  });
                },
              ),
              SizedBox(width: 20),
              ElevatedButton(
                child: Text("High"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffA32F7D)),
                onPressed: () {
                  setState(() {
                    importance = 'High';
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          ))));

  Future<Position> openLocationWindow() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions denied ');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions permanently denied');
    }
    return await Geolocator.getCurrentPosition();
  }
}
