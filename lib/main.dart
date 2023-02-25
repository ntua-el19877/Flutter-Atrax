// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:atrax/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'components/HiveInit.dart';

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
  var friendbox = await Hive.openBox('friendbox');
  // box.clear();

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
