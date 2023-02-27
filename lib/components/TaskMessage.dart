import 'dart:io';

import 'package:atrax/components/CustomRectangle.dart';
import 'package:atrax/components/IconRow.dart';
import 'package:atrax/components/plus_Button.dart';
import 'package:atrax/pages/HomePage.dart';
import 'package:atrax/pages/modifyTaskPage.dart';
import 'package:atrax/routes/routes.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/color_state.dart';
import 'TaskInfo.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class TaskMessage extends StatefulWidget {
  final Box mybox;
  final String boxkey;
  final int index;
  final double screen_width;
  final double RemoveWidth;
  final Color color_Secondary;
  final Color color_Primary;
  final Color color_Blacks;
  final Color color_Red;
  final Color color_Green;
  final Color color_Success;
  final String completed;
  final String name;
  final String description;
  final String date;
  final String time;
  final String repetitiveness;
  final List<Map<String, String>> notifications;
  // final List<String> notifications_time;
  final String importance;
  final String location;
  // final String longtitude;
  final String recording_file_path;
  final String photo_file_path;
  final List<String> friend_name;
  // final List<dynamic> indexListDate;
  // final List<dynamic> indexListTime;
  final Function(int) onTap;

  TaskMessage({
    required this.mybox,
    this.index = 0,
    required this.boxkey,
    required this.completed,
    this.screen_width = 200,
    this.RemoveWidth = 0,
    this.color_Secondary = const Color(0xff929ae7),
    this.color_Primary = const Color(0xffe6f4f1),
    this.color_Blacks = const Color(0xff252525),
    this.color_Red = const Color(0xffae4e54),
    this.color_Success = const Color(0xff06661b),
    required this.color_Green,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.repetitiveness,
    required this.notifications,
    required this.importance,
    required this.location,
    // required this.longtitude,
    required this.recording_file_path,
    required this.photo_file_path,
    required this.friend_name,
    // required this.indexListDate,
    // required this.indexListTime,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _TaskMessageState createState() => _TaskMessageState();
}

class _TaskMessageState extends State<TaskMessage> {
  late List<bool> emptyFields;
  final audioPlayer = AudioPlayer();

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  IconData checkIcon = Icons.check_box_rounded;
  @override
  void didUpdateWidget(TaskMessage oldWidget) {
    if ((oldWidget.color_Secondary != widget.color_Secondary) ||
        (oldWidget.completed != widget.mybox.getAt(widget.index).completed)) {
      // color_secondary has changed, rebuild the widget
      // print("i want to update");
      setState(() {});
    }
    // print('old key: ${oldWidget.key}');
    // print('new key: ${widget.key}');
    // print("i want to update a little");
    super.didUpdateWidget(oldWidget);
  }

  void check() {
    emptyFields = [true, true, true, true, true, true, true, true, true, true];

    if (widget.description == "") emptyFields[0] = false;
    if (widget.repetitiveness == "") emptyFields[1] = false;
    if (widget.notifications.isEmpty) emptyFields[2] = false;
    if (widget.location == "") emptyFields[3] = false;
    if (widget.recording_file_path == "") emptyFields[4] = false;
    if (widget.photo_file_path == "") emptyFields[5] = false;
    if (widget.date == "") emptyFields[6] = false;
    if (widget.time == "") emptyFields[7] = false;
    if (widget.importance == "") emptyFields[8] = false;
    if (widget.friend_name.isEmpty) emptyFields[9] = false;
  }

  /*@override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }*/

  late ColorModel colorModel;
  Color _color_TaskMessage = Colors.red;
  @override
  void initState() {
    if (widget.completed == 'true') {
      _color_TaskMessage = widget.color_Green;
    } else {
      _color_TaskMessage = widget.color_Secondary;
    }
    colorModel = ColorModel();
    colorModel.setColor(_color_TaskMessage, widget.boxkey);
    // if (widget.mybox.get(widget.boxkey).completed == 'false') {
    //   checkIcon = Icons.check_box_rounded;
    // } else {
    //   checkIcon = Icons.check_box_outline_blank;
    // }
    super.initState();
    colorModel.setColor(color_Secondary, widget.boxkey);
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    // audioPlayer.onAudioPositionChanged.listen((newPosition) {
    //   setState(() {
    //     position = newPosition;
    //   });
    // });
    // audioPlayer.onAudioPositionChanged.listen((newPosition){s})
  }

  @override
  Widget build(BuildContext context) {
    check();
    double iconHeight = 22;
    double iconRoomHeight = 15;
    return Consumer<ColorModel>(
      builder: (context, colorModel, child) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanUpdate: (details) {
            int sensitivity = 8;
            // Swiping in right direction.
            if (details.delta.dx > sensitivity) {
              setState(() {
                _color_TaskMessage = widget.color_Green;
                widget.mybox.getAt(widget.index).completed = 'true';

                colorModel.setColor(_color_TaskMessage, widget.boxkey);

                checkIcon = colorModel.getIcon(widget.boxkey);
                // print("$_color_TaskMessage");
              });
            }

            // Swiping in left direction.
            if (details.delta.dx < -sensitivity) {
              setState(() {
                _color_TaskMessage = widget.color_Secondary;
                widget.mybox.getAt(widget.index).completed = 'false';
                colorModel.setColor(_color_TaskMessage, widget.boxkey);
                checkIcon = colorModel.getIcon(widget.boxkey);
                // print("$_color_TaskMessage");
              });
            }
          },
          onTap: () {
            openTaskWindow();
            // pauseAudio();
          },
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - widget.RemoveWidth,
                height: 60,
                decoration: BoxDecoration(
                  color: colorModel.getColor(widget.boxkey),
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
                              colorModel.getIcon(widget.boxkey),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        child: Text(
                                          "${widget.time} ",
                                          style: TextStyle(
                                            color: widget.color_Blacks,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 0),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.end,
                                          // crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                                height: iconRoomHeight,
                                                width: 10),
                                            SizedBox(
                                              height: iconRoomHeight,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
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
              Positioned(
                  top: 5,
                  right: 5,
                  child: Stack(alignment: Alignment.center, children: [
                    if (widget.importance != '')
                      Container(
                        width: 54,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(45),
                            right: Radius.circular(45),
                          ),
                          color: widget.color_Primary,
                        ),
                      ),
                    if (widget.importance != '')
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(45),
                            right: Radius.circular(45),
                          ),
                          color: _getColor(),
                        ),
                        child: Text(widget.importance,
                            style: TextStyle(color: widget.color_Primary)),
                      ),
                  ])),
            ],
          ),
        );
      },
    );
  }

  Color _getColor() {
    if (widget.importance == 'High') {
      return const Color(0xffa32f7d);
    } else if (widget.importance == 'Mid') {
      return const Color(0xffa15eaf);
    }
    return Color(0xff9787d7);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  // void playAudio() async {
  //   await audioPlayer.play(widget.recording_file_path);
  //   setState(() {
  //     isPlaying = true;
  //   });
  // }

  // void pauseAudio() async {
  //   await audioPlayer.pause();
  //   setState(() {
  //     isPlaying = false;
  //   });
  // }

  Future openTaskWindow() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    color: widget.color_Blacks,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // RawMaterialButton(
                //   onPressed: () => Navigator.of(context).pop(),
                //   elevation: 2.0,
                //   fillColor: Colors.white,
                //   child: Icon(
                //     Icons.close,
                //     size: 15.0,
                //   ),
                //   padding: EdgeInsets.only(right: 0),
                //   shape: CircleBorder(),
                // ),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: Icon(Icons.menu, color: Colors.white),
                //   style: ElevatedButton.styleFrom(
                //     shape: CircleBorder(),
                //     padding: EdgeInsets.all(20),
                //     backgroundColor: Colors.blue, // <-- Button color
                //     foregroundColor: Colors.red, // <-- Splash color
                //   ),
                // )
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            content: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                // height: 500,
                width: widget.screen_width * 3 / 4,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (emptyFields[0])
                        Container(
                          padding: const EdgeInsets.only(
                              left: 0, bottom: 10, top: 10, right: 0),
                          child: CustomRectangle(
                            expandable: true,
                            width: widget.screen_width * 3 / 4 - 20,
                            text: widget.description,
                            title: "Description",
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: _paddingIfFIelds67(),
                            top: _paddingIfFIelds67()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Set to CrossAxisAlignment.start
                          children: [
                            if (emptyFields[6])
                              Flexible(
                                // Wrap the child widget with a Flexible widget
                                child: Container(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CustomRectangle(
                                      width: widget.screen_width * 3 / 8 - 15,
                                      text: widget.date,
                                      title: "Date"),
                                ),
                              ),
                            if (emptyFields[7])
                              Flexible(
                                // Wrap the child widget with a Flexible widget
                                child: Container(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: CustomRectangle(
                                      width: widget.screen_width * 3 / 8 - 15,
                                      text: widget.time,
                                      title: "Time"),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: _paddingIfFIelds18(),
                            top: _paddingIfFIelds18()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Set to CrossAxisAlignment.start
                          children: [
                            if (emptyFields[1])
                              Flexible(
                                // Wrap the child widget with a Flexible widget
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: CustomRectangle(
                                      width: widget.screen_width * 3 / 8 - 15,
                                      text: widget.repetitiveness,
                                      title: "Repeat"),
                                ),
                              ),
                            if (emptyFields[8])
                              Flexible(
                                  // Wrap the child widget with a Flexible widget
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: CustomRectangle(
                                          width:
                                              widget.screen_width * 3 / 8 - 15,
                                          text: widget.importance,
                                          title: "Importance"))),
                          ],
                        ),
                      ),
                      for (int i = 0; i < widget.notifications.length; i++)
                        Container(
                          padding: const EdgeInsets.only(
                              top: 10, right: 0, left: 0, bottom: 10),
                          child: CustomRectangle(
                              width: widget.screen_width * 3 / 4 - 20,
                              text: "${widget.notifications[i].entries.last.value}    " +
                                  "${widget.notifications[i].entries.first.value}",
                              title: "Notifications"),
                        ),
                      if (emptyFields[3])
                        GestureDetector(
                          onTap: () {
                            // MapUtils.openMap(double.parse(widget.latitude),
                            //     double.parse(widget.longtitude));
                            MapsLauncher.launchQuery(widget.location);
                          },
                          child: Container(
                            width: widget.screen_width * 3 / 4 - 20,
                            padding: const EdgeInsets.only(
                                left: 0, bottom: 10, top: 10, right: 0),
                            child: CustomRectangle(
                                // myIconEnabled: true,
                                // myIconSize: 30,
                                // myIcon: Icons.location_on_outlined,
                                // myIconColor: Colors.red,
                                Rad: 30,
                                width: (widget.screen_width * 3 / 4 - 20),
                                text: widget.location,
                                title: "Location"),
                          ),
                        ),
                      if (emptyFields[5])
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            height: 100,
                            child: Text(widget.photo_file_path),
                            // Image.file(
                            // File(widget.photo_file_path),
                            // width: MediaQuery.of(context).size.width / 2,
                          ),
                        ),
                      // ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              // Slider(
                              //   min: 0,
                              //   max: duration.inSeconds.toDouble(),
                              //   thumbColor: widget.color_Blacks,
                              //   inactiveColor: widget.color_Blacks,
                              //   onChanged: (value) async {
                              //     final position =
                              //         Duration(seconds: value.toInt());
                              //     await audioPlayer.seek(position);
                              //     await audioPlayer.resume();
                              //   },
                              //   value: position.inSeconds.toDouble(),
                              // ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 16),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(formatTime(position)),
                              //       Text(formatTime(duration - position))
                              //     ],
                              //   ),
                              // ),
                              if (widget.recording_file_path != '')
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Positioned(
                                    top: 0,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () async {
                                        // if (isPlaying) {
                                        //   await audioPlayer.pause();
                                        //   // pauseAudio();
                                        // } else {
                                        // String url =
                                        //     'https://www.youtube.com/results?search_query=e+scooby+dooby+doo+where+are+you';
                                        // 'assets/recordings/Scoobydoo.mp3';
                                        // await audioPlayer
                                        //     .play(Uri.parse('asset:///assets/recordings/Scoobydoo.mp3'));
                                        // .play('assets/recordings/Scoobydoo.mp3');
                                        // playAudio();
                                        final player = AudioCache();
                                        player.play(widget.recording_file_path);
                                        // }
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final player = AudioCache();
                                              player
                                                  .play('assets/TestAudio.mp3');
                                              // }
                                            },
                                            child: CustomRectangle(
                                                // myIconEnabled: true,
                                                // myIconSize: 30,
                                                // myIcon: Icons.location_on_outlined,
                                                // myIconColor: Colors.red,
                                                Rad: 30,
                                                width: (widget.screen_width *
                                                        3 /
                                                        4 -
                                                    20),
                                                text: 'Tap to play Audio',
                                                title: 'Audio Recording'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              // CircleAvatar(
                              //     radius: 35,
                              //     backgroundColor: widget.color_Secondary,
                              //     child: IconButton(
                              //       icon: Icon(
                              //         color: widget.color_Primary,
                              //         isPlaying
                              //             ? Icons.pause
                              //             : Icons.play_arrow,
                              //       ),
                              //       iconSize: 50,
                              //       onPressed: () async {
                              //         // if (isPlaying) {
                              //         //   await audioPlayer.pause();
                              //         //   // pauseAudio();
                              //         // } else {
                              //         // String url =
                              //         //     'https://www.youtube.com/results?search_query=e+scooby+dooby+doo+where+are+you';
                              //         // 'assets/recordings/Scoobydoo.mp3';
                              //         // await audioPlayer
                              //         //     .play(Uri.parse('asset:///assets/recordings/Scoobydoo.mp3'));
                              //         // .play('assets/recordings/Scoobydoo.mp3');
                              //         // playAudio();
                              //         final player = AudioCache();
                              //         player.play(widget.recording_file_path);
                              //         // }
                              //       },
                              //     )),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => modifyTaskPage(
                                        box: widget.mybox,
                                        emptyFields: emptyFields,
                                        boxkey: widget.boxkey,
                                      ),
                                    ),
                                  ).then((value) {
                                    Navigator.pop(context);
                                  });
                                  setState(() {});
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (states) => widget.color_Success,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    Size(120, 50),
                                  ),
                                ),
                                child: Text(
                                  "Modify",
                                  style: TextStyle(
                                    color: widget.color_Primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  widget.mybox.delete(widget.boxkey);
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (states) => widget.color_Red,
                                  ),
                                  shape: MaterialStateProperty.resolveWith<
                                      OutlinedBorder>(
                                    (states) => RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    Size(120, 50),
                                  ),
                                ),
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: widget.color_Primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // if (emptyFields[4])
                      // GestureDetector(
                      //   onTap: () {
                      //     // MapUtils.openMap(double.parse(widget.latitude),
                      //     //     double.parse(widget.longtitude));
                      //     // MapsLauncher.launchCoordinates(
                      //     //     double.parse(widget.latitude),
                      //     //     double.parse(widget.longtitude));
                      //   },
                      // child:
                      // Container(
                      //     padding: const EdgeInsets.all(10),
                      //     child: Column(
                      //       children: [

                      //         // CustomRectangle(
                      //         //     // myIconEnabled: true,
                      //         //     myIconSize: 30,
                      //         //     myIcon: Icons.location_on_outlined,
                      //         //     myIconColor: Colors.red,
                      //         //     //Rad: 30,
                      //         //     width: (widget.screen_width * 3 / 4),
                      //         //     text:
                      //         //         widget.latitude + "  ,  " + widget.longtitude,
                      //         //     title: "Recording"),
                      //       ],
                      //     )),
                    ]),
              ),
            ),
          ));
  double _paddingIfFIelds67() {
    if (emptyFields[6] || emptyFields[7]) {
      return 10;
    }
    return 0;
  }

  double _paddingIfFIelds18() {
    if (emptyFields[1] || emptyFields[8]) {
      return 10;
    }
    return 0;
  }
}
