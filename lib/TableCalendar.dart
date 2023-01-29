import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/*

class CalendarTable extends StatelessWidget {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day,DateTime focusedDay){
   setState(){
      today = day;
   }; 
  }

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        child: TableCalendar (
          availableGestures : AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day,today),
          focusedDay: today, 
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030,3,14),
          onDaySelected : _onDaySelected,
          )
      );
  }
}

*/

class CalendarTable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarTableState();
  }
}

class _CalendarTableState extends State<CalendarTable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            color: Color(0xff929AE7),
            child: TableCalendar(
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              onDaySelected: _onDaySelected,
            )));
  }

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }
}
