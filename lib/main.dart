import 'package:flutter/material.dart';
import 'package:atrax/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'components/HiveInit.dart';

void main() async {
  // Initialize hive
  await Hive.initFlutter();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter<Task>(TaskAdapter());

  //showing hive how to read/write Task
  Hive.registerAdapter(TaskAdapter());

  //open box(database)
  var box = await Hive.openBox('mybox');
  box.clear();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  runApp(MyApp(box: box));
}

class MyApp extends StatelessWidget {
  final Box box;

  const MyApp({Key? key, required this.box}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: RouteManager.mainpage,
      onGenerateRoute: (settings) {
        return RouteManager.generateRoute(settings, box: box);
      },
    );
  }
}
