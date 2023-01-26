import 'package:atrax/components/HomeDownBar.dart';
import 'package:flutter/material.dart';
import 'package:atrax/routes/routes.dart';
//import ' package: atrax/lib/components/HomeDownBar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final bottomNavBarHeight = (screenHeight / 12);
    return Scaffold(
      backgroundColor: const Color(0xffe6f4f1),

      // appBar: AppBar(
      //   title: const Text('Atrax Main Page'),
      //   toolbarHeight: 40,
      // ),

      bottomNavigationBar: HomeDownBar(
        currentIndex: currentIndex,
        top: screenHeight,
        circle_front_Radius: 35,
        circle_back_Radius: 40,
        preferredSize: bottomNavBarHeight,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: Center(
          child: (ElevatedButton(
              child: const Text('Go to secondPage'),
              onPressed: () {
                //Navigator.of(context).pushNamed(RouteManager.secondpage);
                Navigator.of(context).pushNamed(RouteManager.secondpage);
              }))),
    );
  }
}
