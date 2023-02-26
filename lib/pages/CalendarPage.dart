import 'package:atrax/components/CalendarDownBar.dart';
import 'package:atrax/components/ColumnTaskMessagesFromList.dart';
import 'package:atrax/components/TaskMessage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../routes/routes.dart';
import '../MyWidgets.dart';
import '../TableCalendar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  final Box box;
  var tasks = [];

  CalendarPage({Key? key, required this.box}) : super(key: key);

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
  @override
  void initState() {
    DateTime today = DateTime.now();
    print(today.toString());
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(today);
    print(formatted);
    //var date = widget.box.getAt(1).date;
    tasks = widget.box.values.where((task) => task.date == formatted).toList();
    print("1st print :");
    print(tasks);
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
          Positioned(child: getSelectedDayTasks(), top: 0.5 * screenHeight),
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
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      print("You selected the day");
      print(today.toString());
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(today);
      print(formatted);
      //var date = widget.box.getAt(1).date;
      //print(date);
      tasks =
          widget.box.values.where((task) => task.date == formatted).toList();
      //print(tasks[0].date);
    });
  }

  Widget getSelectedDayTasks() {
    return ColumnTaskMessagesFromList(
        mybox: widget.box,
        myboxList: tasks,
        color_Secondary: color_Secondary,
        color_Green: color_Green,
        screenWidth: MediaQuery.of(context).size.width,
        TaskLeftPadding: TaskLeftPadding,
        currentIndex: 0);
  }
}
