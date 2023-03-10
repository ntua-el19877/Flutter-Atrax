import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../pages/HomePage.dart';
import '../pages/SecondPage.dart';
import '../pages/ThirdPage.dart';
import '../pages/CalendarPage.dart';
import '../pages/AddTaskPage.dart';
import '../pages/FriendsPage.dart';
import '../pages/modifyTaskPage.dart';

class RouteManager {
  static const String mainpage = '/';
  static const String secondpage = '/secondpage';
  static const String thirdpage = '/thirdpage';
  static const String calendarpage = '/calendarpage';
  static const String addtaskpage = '/addtaskpage';
  static const String friendspage = '/friendspage';

  static const String modifytaskpage = '/modifyTaskPage';

  static Route<dynamic> generateRoute(RouteSettings settings,
      {required Box box, required Box friendbox}) {
    switch (settings.name) {
      case mainpage:
        return MaterialPageRoute(
            builder: (context) => MainPage(box: box, friendbox: friendbox));

      case secondpage:
        return MaterialPageRoute(builder: (context) => SecondPage());
      case thirdpage:
        return MaterialPageRoute(builder: (context) => ThirdPage());

      case calendarpage:
        return MaterialPageRoute(
            builder: (context) => CalendarPage(
                  box: box,
                  friendbox: friendbox,
                ));
      // case modifytaskpage:
      //   return MaterialPageRoute(
      //       builder: (context) => modifyTaskPage(box: box));

      case addtaskpage:
        return MaterialPageRoute(
            builder: (context) => AddTaskPage(box: box, friendbox: friendbox));

      case friendspage:
        return MaterialPageRoute(
            builder: (context) => FriendsPage(box: box, friendbox: friendbox));

      default:
        throw const FormatException('Route not found');
    }
  }
}
