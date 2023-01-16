import 'package:flutter/material.dart';
import 'package:atrax/routes/routes.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Atrax Main Page'),
      ),
      body: Center(
          child: (ElevatedButton(
              child: const Text('Go to secondPage'),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteManager.secondpage);
                //Navigator.of(context).pushNamed('/secondpage');
              }))),
    );
  }
}
