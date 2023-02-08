import 'package:flutter/material.dart';

import '../routes/routes.dart';
import '../MyWidgets.dart';
import '../TableCalendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      */
      body: CalendarTable(),
      backgroundColor: const Color(0xffE6F4F1),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 0,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushNamed(RouteManager.mainpage);
              break;
            case 1:
              Navigator.of(context).pushNamed(RouteManager.secondpage);
              break;
          }
        },
      ),
    );
  }
}
