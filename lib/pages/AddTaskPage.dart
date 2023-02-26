import 'dart:io';
import 'dart:math';

import 'package:atrax/entities/AddTaskJSON.dart';
import 'package:atrax/file_manager.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/notifi_service.dart';
import '../routes/routes.dart';
import '../GoogleMap.dart';

import 'package:flutter/material.dart';
//import 'package:atrax/entities/TaskJSON.dart';

import 'package:geolocator/geolocator.dart';

import 'package:intl/intl.dart';
// <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />;

import '../components/HiveInit.dart' as HiveInit;

String formatDate(var day) {
  print(day.month.runtimeType);
  var m = day.month.toString().length;
  var d = day.day.toString().length;
  var formatted_day;
  formatted_day = "${day.year}-${day.month}-${day.day}";
  print("month digits : " + m.toString() + " day digits : " + d.toString());
  if (m == 1) {
    print("Adding zero to month");
    formatted_day = "${day.year}-${"0" + day.month.toString()}-${day.day}";
  }
  if (d == 1) {
    print("Adding zero to day");
    formatted_day = "${day.year}-${day.month}-${"0" + day.day.toString()}";
  }
  if (m == 1 && d == 1) {
    print("Adding zero to day and month");
    formatted_day =
        "${day.year}-${"0" + day.month.toString()}-${"0" + day.day.toString()}";
  }
  return formatted_day;
}

String convertTo24HourFormat(String time) {
  final format = DateFormat('h:mm a');
  final dateTime = format.parse(time);
  final twentyFourHourFormat = DateFormat('HH:mm');
  return twentyFourHourFormat.format(dateTime);
}

bool is24HourFormat(String time) {
  RegExp regExp = new RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
  return regExp.hasMatch(time);
}

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
  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  String audioFile = '';
  double IconSpacing = -15;
  double IconSize = 30;
  File _image = File('assets/icons/empty.png');
  final imagePicker = ImagePicker();
  var _TaskController = TextEditingController(); /*  task controller  */
  final _DescriptionController =
      TextEditingController(); /*  description controller  */

  /*DateTime due_date = DateTime.now();   */
  DateTime due_date = DateUtils.dateOnly(DateTime.now());
  var DueDate = ''; /*  user due date  */
  var useless_date = '';

  TimeOfDay due_time = TimeOfDay(hour: 8, minute: 00);
  var DueTime = ''; /*  user due time  */

  var repetitiveness = '';

  var importance = '';

  var lat = ''; /*  GPS variables  */
  var long = '';

  String imageDestination = '';

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
  List<Map<String, String>> new_notifications_list = [];

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

            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                  color: Color(0xffff929AE7),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing:
                        IconSpacing, // adjust the spacing between the icons horizontally
                    runSpacing:
                        8.0, // adjust the spacing between the rows vertically
                    children: [
                      TextButton(
                        //child: Text("Calendar"),
                        onPressed: openDatePicker,
                        //child: Text("Calendar"),
                        child: Icon(Icons.date_range_rounded,
                            size: IconSize, color: Color(0xff252525)),
                      ),
                      TextButton(
                        //child: Text("Clock"),
                        onPressed: openTimePicker,
                        //child: Text("Clock"),
                        child: Icon(Icons.access_time,
                            size: IconSize, color: Color(0xff252525)),
                      ),
                      TextButton(
                        //child: Text("Repeat"),
                        onPressed: openRepetitiveness,
                        //child: Text("Repeat"),
                        child: Icon(Icons.replay,
                            size: IconSize, color: Color(0xff252525)),
                      ),
                      TextButton(
                        onPressed: openNotificationWindow,
                        child: Icon(Icons.notifications_none_outlined,
                            size: IconSize, color: Color(0xff252525)),
                      ),
                      TextButton(
                        onPressed: openImportanceWindow,
                        child: Icon(Icons.outlined_flag,
                            size: IconSize, color: Color(0xff252525)),
                      ),
                      TextButton(
                          child: Icon(Icons.location_on_outlined,
                              size: IconSize, color: Color(0xff252525)),
                          onPressed: () {
                            openLocationWindow().then((value) {
                              lat = '${value.latitude}';
                              long = '${value.longitude}';
                              MapUtils.openMap(lat, long);
                            });
                          }),
                      TextButton(
                        onPressed: openCamera,
                        child: Icon(Icons.photo_camera_outlined,
                            size: IconSize, color: Color(0xff252525)),
                      ),
                      TextButton(
                        onPressed: openRecorder,
                        child: Icon(Icons.mic_none,
                            size: IconSize, color: Color(0xff252525)),
                      ),
                    ],
                  )),
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

            // /*    SAVED PARAMETERS WINDOW   */
            // Container(
            //   color: Colors.green,
            //   child: Column(children: [
            //     Text("USER'S INPUTS"),
            //     Text("Task name :"),
            //     Text(task),
            //     Text("Task Decription :"),
            //     Text(description),
            //     Text("Due date"),
            //     Text(DueDate),
            //     Text("Due time"),
            //     Text(DueTime),
            //     Text("Your Location :"),
            //     Text(long + " " '$lat')
            //   ]),
            // ),
          ],
        ));
  }

  String generateRandomString() {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random.secure();
    return List.generate(9, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  String returnlocation() {
    if (lat == '')
      return '';
    else
      return lat + ',' + long;
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
      //notifications: widget.box.getAt(0).notifications,
      notifications: new_notifications_list,
      importance: importance,
      location: returnlocation(),
      recordingFilePath: audioFile,
      photoFilePath: imageDestination,
      friendName: ['John', 'Jane'],
      completed: 'false',
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
      'photoFilePath': imageDestination,
      'friendName': ["julie", "jess"]
    };
    await AddTaskData.saveJsonData(rawData);
    //AddTaskData.getJsonData();
    //AddTaskData.parseJson(rawData);
    //FileManager().writeJsonFile(rawData);

    if (DueDate != '' && DueTime != '') {
      print("Due Date " + DueDate + " Due Time " + DueTime);
      //print(convertTo24HourFormat(DueTime));

      //DateTime day = DateTime.parse(DueDate);
      //print("day :" +'$day');
      //DateTime time = DateTime.parse(DueTime+':00');
      //print(time.toString());
      //DateTime dateTime = DateTime(day.year, day.month, day.day, time.hour, time.minute, time.second);

      //DateTime day = DateTime.parse(DueDate);
      //print("day :" +'$day');
      //DateTime time = DateTime.parse(DueTime+':00');
      //print(time.toString());
      //DateTime dateTime = DateTime(day.year, day.month, day.day, time.hour, time.minute, time.second);

      //var passed_time = DateTime.parse('$DueDate $DueTime');
      //print("Passed time : " + passed_time.toString());
      NotificationService().scheduleNotification(
          title:
              _TaskController.text + " " + DueDate + " " + DueTime + " (Now)",
          body: _DescriptionController.text,
          scheduledNotificationDateTime:
              DateTime.parse('$DueDate' + ' ' + '$DueTime'));
    }

    if (list_counter > 0) {
      for (int i = 0; i < list_counter; i++) {
        print("Notification date : " +
            new_notifications_list[i].entries.first.value +
            " Notification time :" +
            new_notifications_list[i].entries.last.value);
        if (new_notifications_list[i].entries.last.value != '' &&
            new_notifications_list[i].entries.first.value != '') {
          NotificationService().scheduleNotification(
              title: _TaskController.text +
                  " " +
                  new_notifications_list[i].entries.first.value +
                  " " +
                  new_notifications_list[i].entries.last.value,
              body: _DescriptionController.text,
              scheduledNotificationDateTime: DateTime.parse(
                  new_notifications_list[i].entries.first.value +
                      ' ' +
                      new_notifications_list[i].entries.last.value));
        }
      }
    }

    Navigator.of(context).pop();
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
        //DueDate = "${due_date.day}-${due_date.month}-${due_date.year}";
        //print(due_date.month.runtimeType);
        DueDate = "${due_date.year}-${due_date.month}-${due_date.day}";
        DueDate = formatDate(due_date);
        print(DueDate);
      });
    });
  }

  void openTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        due_time = value!;
        DueTime = due_time.format(context).toString();
        DueTime = is24HourFormat(due_time.format(context).toString())
            ? due_time.format(context).toString()
            : convertTo24HourFormat(due_time.format(context).toString());
        //DueTime = convertTo24HourFormat(due_time.format(context).toString());
        print(DueTime);
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
            new_notifications_list = [];
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
              new_notifications_list = [];
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

        //NotDate =
        //    "${notification_date.day}-${notification_date.month}-${notification_date.year}";
        NotDate = formatDate(notification_date);
        Notifications_Day_and_Time[0] = NotDate;
        Notifications_List[list_counter][0] = NotDate;
        new_Notifications_List[list_counter] = Notification(NotDate, NotTime);

        if (Notifications_List[list_counter][1] != '') {
          list_counter = list_counter + 1;

          final Map<String, String> notifications_map = {
            "date": NotDate,
            "time": NotTime
          };
          new_notifications_list.insert(list_counter - 1, notifications_map);
          print(new_notifications_list);
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
        //NotTime = notification_time.format(context).toString();
        NotTime = is24HourFormat(notification_time.format(context).toString())
            ? notification_time.format(context).toString()
            : convertTo24HourFormat(
                notification_time.format(context).toString());
        //NotTime = is24HourFormat(notification_time.toString()) ? convertTo24HourFormat(notification_time.format(context).toString()) : notification_time.toString();
        Notifications_Day_and_Time[1] = NotTime;
        Notifications_List[list_counter][1] = NotTime;
        new_Notifications_List[list_counter] = Notification(NotDate, NotTime);

        if (Notifications_List[list_counter][0] != '') {
          list_counter = list_counter + 1;

          final Map<String, String> notifications_map = {
            "date": NotDate,
            "time": NotTime
          };
          new_notifications_list.insert(list_counter - 1, notifications_map);
          print(new_notifications_list);
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
            ),
          ),
        ),
      );

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

  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> saveImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath =
        '${directory.path}/photos/${DateTime.now().millisecondsSinceEpoch}.jpg';
    imageDestination = imagePath;
    final imageFile = await _image.copy(imagePath);
    // print('--------------------------Image saved to: ${imageFile.path}');
  }

  // bool loading = false;

  // Future<bool> saveFile() async {}
  // downloadFile() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   bool downloaded = saveFile();
  //   setState(() {
  //     loading = false;
  //   });
  // }

  void openCamera() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("Take Picture"),
            content: Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_image != null)
                  Image.file(
                    _image,
                    width: MediaQuery.of(context).size.width / 2,
                  )
                else
                  Text('No Image Selected'),
                ElevatedButton(
                  onPressed: () async {
                    await getImage();
                    // print("---------------1");
                    if (_image != null) {
                      // print("---------------2");
                      await saveImage();
                    }
                    setState(() {
                      _image;
                    });
                  },
                  child: const Icon(Icons.camera_alt),
                )
              ],
            ))),
      );
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  Future stop() async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    audioFile = File(path!) as String;
    // print('Recorded audio:$audioFile');
    await recorder.stopRecorder();
  }

  void openRecorder() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          // title: Text("Recor"),
          content: SizedBox(
              child: Column(
            children: [
              StreamBuilder<RecordingDisposition>(
                stream: recorder.onProgress,
                builder: (context, snapshot) {
                  final duration = snapshot.hasData
                      ? snapshot.data!.duration
                      : Duration.zero;
                  String twoDigits(int n) => n.toString().padLeft(1);
                  final twoDigitMinutes =
                      twoDigits(duration.inMinutes.remainder(60));
                  final twoDigitSeconds =
                      twoDigits(duration.inSeconds.remainder(60));
                  return Text('$twoDigitMinutes:$twoDigitSeconds',
                      style: const TextStyle(
                          fontSize: 80, fontWeight: FontWeight.bold));
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                child: Icon(recorder.isRecording ? Icons.stop : Icons.mic,
                    size: 80),
                onPressed: () async {
                  if (recorder.isRecording) {
                    await stop();
                  } else {
                    await record();
                  }
                },
              ),
            ],
          )),
        ),
      );
  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }
}
