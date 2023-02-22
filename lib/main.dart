import 'package:flutter/material.dart';
import 'package:atrax/routes/routes.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  // Initialize hive
  await Hive.initFlutter();

  //open box(database)
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application..
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.mainpage,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
