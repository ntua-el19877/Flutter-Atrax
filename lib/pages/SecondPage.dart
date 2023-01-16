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
      // body: Center(
      //     child: (ElevatedButton(
      //         child: const Text('Go to secondPage'),
      //         onPressed: () {
      //           Navigator.of(context).pushNamed(RouteManager.mainpage);
      //           //Navigator.of(context).pushNamed('/secondpage');
      //         }))),
    );
  }
}
