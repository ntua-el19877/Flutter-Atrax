import 'package:flutter/material.dart';

import '../routes/routes.dart';

class AddTaskPage extends StatefulWidget{
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
   
}
class _AddTaskPageState extends State <AddTaskPage>{

  final _TaskController = TextEditingController();
  final _DescriptionController = TextEditingController();

  String task = '';
  String description = ''; 

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
      /*    TASK NAME AND DESCRIPTION INPUTS   */
      Container (
        width : MediaQuery.of(context).size.width,
        height : 170,
        child :  Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children : <Widget> [
          Text ('Task name : ',
          style: TextStyle(fontSize: 25),
          ),
          TextField(
            controller : _TaskController,
            decoration : InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          )
          ),
          Text ('Description : ',
          style: TextStyle(fontSize: 25),
          ),
          TextField(
            controller : _DescriptionController,
            decoration : InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          )
          ),
        ],
        ),
        decoration : BoxDecoration (
          color :  Color(0xff929AE7),
          border : Border.all(
            color: Color(0xff929AE7)
            ),
         ),
        
      ),

      /*   CONFIRM BUTTONS  */
      Container (
        width : MediaQuery.of(context).size.width,
        height : 50,
        decoration : BoxDecoration (
          color :  Color(0xff929AE7),
          border : Border.all(
            color: Color(0xff929AE7)
            ),
         ),
         child: Row (
          children : <Widget> [
            ElevatedButton (
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff06661B), // Background color
                  ),
              child :Text('Confirm'),
              onPressed: _SaveTask,
              ),
              ElevatedButton (
              style: ElevatedButton.styleFrom(
                  primary: Color(0xffA32F7D), // Background color
                  ),
              child :Text('Invite a friend'),
              onPressed: _SaveTask,
              ),
          ],
         ),
      ),

      /*    SAVED PARAMETERS WINDOW   */
      Container (
        color: Colors.green,
        child: Column(
          children : [
            Text("USER'S INPUTS"),
            Text("Task name :"),
            Text(task),
            Text("Task Decription :"),
            Text(description)
          ]
        ),
      ),
      ],
      )
    );

}
void _SaveTask(){
  setState((){
  task = _TaskController.text; 
  description = _DescriptionController.text;
  });
}
}