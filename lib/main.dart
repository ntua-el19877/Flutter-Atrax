import 'dart:io';

import 'package:flutter/material.dart';
import 'package:atrax/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'components/HiveInit.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Services/notifi_service.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize hive
  await Hive.initFlutter();
 //Directory document = await getApplicationDocumentsDirectory();
  //Hive.init(document.path);
  // Hive.registerAdapter<Task>(TaskAdapter());

  //showing hive how to read/write Task
  Hive.registerAdapter(TaskAdapter());

  //showing hive how to read/write Task
  Hive.registerAdapter(FriendAdapter());
  // await Hive.deleteBoxFromDisk('mybox');
  //open box(database) and friendbox
  var box = await Hive.openBox('mybox');
  //await Hive.deleteBoxFromDisk('friendbox');
  var friendbox = await Hive.openBox('friendbox');
  //await friendbox.clear();

    //friendbox.put(0, Friend(name: 'John', last_name: 'A', is_active: true));
    //friendbox.put(1, Friend(name: 'John_2', last_name: 'A', is_active: true));
    //friendbox.put(2, Friend(name: 'John_3', last_name: 'A', is_active: true));
  //}

  NotificationService().initNotification();
  tz.initializeTimeZones();

  WidgetsFlutterBinding.ensureInitialized();

  /*final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  print(isFirstLaunch);
  if (isFirstLaunch) {
    await {
      print("Initializing App"),
     /*friendbox.add(Friend(name: 'John', last_name: 'A', is_active: true)),
      friendbox.add(Friend(name: 'Jane', last_name: 'B', is_active: true)),
      friendbox.add(Friend(name: 'Bob', last_name: 'C', is_active: true)),*/
      prefs.setBool('isFirstLaunch', false),
      print(isFirstLaunch),
    };

    // Set isFirstLaunch to false so the code doesn't run again
    //await prefs.setBool('isFirstLaunch', false);
  }
  */

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  runApp(MyApp(box: box, friendbox: friendbox));
}

class MyApp extends StatelessWidget {
  final Box box;
  final Box friendbox;

  const MyApp({Key? key, required this.box, required this.friendbox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: RouteManager.mainpage,
      onGenerateRoute: (settings) {
        return RouteManager.generateRoute(settings,
            box: box, friendbox: friendbox);
      },
    );
  }
}

void initializeApp(var friendbox){
  print("Initializing App");
  friendbox.add(Friend(name: 'John', last_name: 'A', is_active: true));
  friendbox.add(Friend(name: 'Jane', last_name: 'B', is_active: true));
  friendbox.add(Friend(name: 'Bob', last_name: 'C', is_active: true));
}
