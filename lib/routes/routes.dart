import 'package:flutter/material.dart';

import '../pages/HomePage.dart';
import '../pages/SecondPage.dart';
import '../pages/ThirdPage.dart';

class RouteManager {
  static const String mainpage = '';
  static const String secondpage = '/secondpage';
  static const String thirdpage = '/thirdpage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainpage:
        return MaterialPageRoute(builder: (context) => MainPage());

      case secondpage:
        return MaterialPageRoute(builder: (context) => SecondPage());
      case thirdpage:
        return MaterialPageRoute(builder: (context) => ThirdPage());
      default:
        throw const FormatException('Route not found');
    }
  }
}
