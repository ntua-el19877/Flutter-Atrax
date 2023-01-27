import 'package:flutter/material.dart';

import '../routes/routes.dart';

class AddTaskPage extends StatefulWidget{
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
   
}
class _AddTaskPageState extends State <AddTaskPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: const Text('Add Task Page'),
      ),
      */
      backgroundColor: Color(0xE6F4F1),
      body : Column (
      children : [
      const SizedBox(height:100),
      Container (
        width : MediaQuery.of(context).size.width,
        height : 300,
        
        ),
      ]
         ), 
    );

}
}