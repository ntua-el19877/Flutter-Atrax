import 'package:flutter/material.dart';

import '../pages/HomePage.dart';
import '../pages/SecondPage.dart';
import '../pages/ThirdPage.dart';
import '../pages/CalendarPage.dart';
import '../pages/AddTaskPage.dart';

class RouteManager {
  static const String mainpage = '/';
  static const String secondpage = '/secondpage';
  static const String thirdpage = '/thirdpage';
  static const String calendarpage = '/calendarpage';
  static const String addtaskpage = '/addtaskpage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainpage:
        return MaterialPageRoute(builder: (context) => MainPage());

      case secondpage:
        return MaterialPageRoute(builder: (context) => SecondPage());
      case thirdpage:
        return MaterialPageRoute(builder: (context) => ThirdPage());

      case calendarpage:
        return MaterialPageRoute(builder: (context) => CalendarPage());

      case addtaskpage:
        return MaterialPageRoute(builder: (context) => AddTaskPage());

      default:
        throw const FormatException('Route not found');
    }
  }
}
