import 'package:atrax/components/CalendarDownBar.dart';
import 'package:atrax/components/ColumnTaskMessagesFromList.dart';
import 'package:atrax/components/TaskMessage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../routes/routes.dart';
import '../MyWidgets.dart';
import '../TableCalendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../services/notifi_service.dart';

class CalendarPage extends StatefulWidget {
  final Box friendbox;
  final Box box;
  var tasks = [];

  CalendarPage({Key? key, required this.box, required this.friendbox})
      : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

Color _color_TaskMessage = color_Secondary;
const Color color_Secondary = Color(0xff929ae7);
const Color color_Primary = Color(0xffe6f4f1);
const Color color_Blacks = Color(0xff252525);
const Color color_Red = Color(0xffa54e54);
const Color color_Green = Color(0xff1f8a87);
double TaskLeftPadding = 10;

class _CalendarPageState extends State<CalendarPage> {
  var tasks = [];
  var taskKeys = [];
  @override
  void didUpdateWidget(CalendarPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.box.length != oldWidget.box.length) {
      setState(() {
        updateTasksForSelectedDay();
        // print("----------------------------------");
        // print(taskKeys);
        // getSelectedDayTasks();
      });
    }
  }

  late final ValueListenable<Box> _myBoxListenable;
  @override
  void initState() {
    super.initState();
    DateTime today = DateTime.now();
    // print(today.toString());
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(today);
    // print(formatted);
    //var date = widget.box.getAt(1).date;

    tasks = widget.box.values.where((task) => task.date == formatted).toList();
    taskKeys = widget.box
        .toMap()
        .entries
        .where((entry) => entry.value.date == formatted)
        .map((entry) => entry.key)
        .toList();
    //print("TASKS______________");
    // print(taskKeys);
    _myBoxListenable = widget.box.listenable();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final bottomNavBarHeight = (screenHeight / 12);
    int currentIndex = 0;

    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            SizedBox(
              height: 20,
            ),
            Container(
              //color: Color(0xff929AE7),
              child: Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: SizedBox(
                    height: screenHeight * 0.6,
                    width: screenWidth * 0.85,
                    child: TableCalendar(
                      availableGestures: AvailableGestures.all,
                      selectedDayPredicate: (day) => isSameDay(day, today),
                      focusedDay: today,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      headerStyle: const HeaderStyle(
                          formatButtonVisible: false, titleCentered: true),
                      onDaySelected: _onDaySelected,
                    ),
                  )),
            ),
          ]),
          Positioned(
              top: 0.4 * screenHeight,
              child: ValueListenableBuilder(
                  valueListenable: _myBoxListenable,
                  builder: (context, box, child) {
                    updateTasksForSelectedDay();
                    return Center(
                        // widthFactor: 1,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          const SizedBox(height: 20),
                          Container(
                              color: color_Secondary,
                              child: SizedBox(height: 5)),
                          SizedBox(
                            height: 400,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: ColumnTaskMessagesFromList(
                                  friendbox: widget.friendbox,
                                  taskKeys: taskKeys,
                                  mybox: widget.box,
                                  myboxList: tasks,
                                  color_Secondary: color_Secondary,
                                  color_Green: color_Green,
                                  screenWidth:
                                      MediaQuery.of(context).size.width,
                                  TaskLeftPadding: TaskLeftPadding,
                                  currentIndex: 0),
                            ),
                          ),
                        ]));
                  })),
          CalendarDownBar(
            box: widget.box,
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
        ],
      ),
      backgroundColor: const Color(0xffE6F4F1),
    );
  }

  DateTime today = DateTime.now();
  void updateTasksForSelectedDay() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(today);
    tasks = widget.box.values.where((task) => task.date == formatted).toList();
    taskKeys = widget.box
        .toMap()
        .entries
        .where((entry) => entry.value.date == formatted)
        .map((entry) => entry.key)
        .toList();
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      updateTasksForSelectedDay();
    });
  }

//   Widget getSelectedDayTasks() {
//     return ;
//   }
}
