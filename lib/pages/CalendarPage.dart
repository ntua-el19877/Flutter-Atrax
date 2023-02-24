import 'package:atrax/components/CalendarDownBar.dart';
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

  const CalendarPage({Key? key, required this.box}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}
// var tasks = widget.mybox.values
// .where((task) => task.name == 'My Task1')
// .toList();

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final bottomNavBarHeight = (screenHeight / 12);
    int currentIndex = 0;
    DateTime day;
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
          // getSelectedDayTasks(today),
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
      print(today.toString());
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(today);
      print(formatted);
      // var date = widget.box.getAt(1).date;
      //print(date);
      var tasks =
          widget.box.values.where((task) => task.date == formatted).toList();
      print(tasks[1].name);
    });
  }
  // Widget getSelectedDayTasks(DateTime sel_date){
  //   List<Widget> list = [];
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //   final String formatted = formatter.format(sel_date);
  //   var tasks = widget.box.values
  //                   .where((task) => task.date == formatted)
  //                   .toList();
  //   print(tasks);
  //   if(tasks.length==0){
  //     list.add(
  //       Container()
  //     );
  //   }
  // if(tasks.length>0){
  //   for(int i=0; i<tasks.length; i=i+1){
  //   list.add(
  //     TaskMessage(name: widget.box.getAt(i).name,
  //     description: widget.box.getAt(i).description,
  //     date: widget.box.getAt(i).date,
  //     time: widget.box.getAt(i).time,
  //     repetitiveness: widget.box.getAt(i).repetitiveness,
  //     notifications_date: widget.box.getAt(i).notifications_date,
  //     notifications_time: widget.box.getAt(i).notifications_time,
  //     notifications_halfOfDay: notifications_halfOfDay,
  //     importance: importance,
  //     latitude: latitude,
  //     longtitude: longtitude,
  //     recording_file_path: recording_file_path,
  //     photo_file_path: photo_file_path,
  //     friend_name: friend_name,
  //     indexListDate: indexListDate,
  //     indexListTime: indexListTime,
  //     onTap: onTap)
  //   );
  //   }
  // }
  // }
}
