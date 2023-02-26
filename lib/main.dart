// import 'dart:io';

import 'package:atrax/services/color_state.dart';
import 'package:flutter/material.dart';
import 'package:atrax/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'components/HiveInit.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'services/notifi_service.dart';
import 'package:timezone/data/latest.dart' as tz;

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
  var box = await Hive.openBox('mybox1');
  var friendbox = await Hive.openBox('friendbox');
  box.clear();

  NotificationService().initNotification();
  tz.initializeTimeZones();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ColorModel()),
  ], child: MyApp(box: box, friendbox: friendbox)));
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

void scheduleNotification() {}
