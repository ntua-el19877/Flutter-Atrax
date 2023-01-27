import 'package:flutter/material.dart';

import '../routes/routes.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atrax Second Page'),
      ),
      body: Center(
           child : Column (
            children: [
            ElevatedButton(
               child: const Text('Go to Calendar Page'),
               onPressed: () {
                 Navigator.of(context).pushNamed(RouteManager.calendarpage);
                 //Navigator.of(context).pushNamed('/secondpage');
               }
              ),
            ElevatedButton(
               child: const Text('Go to Add Task Page'),
               onPressed: () {
                 Navigator.of(context).pushNamed(RouteManager.addtaskpage);
                 //Navigator.of(context).pushNamed('/secondpage');
               }
            )
            ]
           )
          ),
    );
  }
}
