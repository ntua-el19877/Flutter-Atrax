import 'package:flutter/material.dart';

import '../routes/routes.dart';
import '../TableCalendar.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _TaskController = TextEditingController(); /*  task controller  */
  final _DescriptionController =
      TextEditingController(); /*  description controller  */

  /*DateTime due_date = DateTime.now();   */
  DateTime due_date = DateUtils.dateOnly(DateTime.now());
  var DueDate = ''; /*  user due date  */

  TimeOfDay due_time = TimeOfDay(hour: 8, minute: 00);
  var DueTime = ''; /*  user due time  */

  TimeOfDay notification_time = TimeOfDay(hour: 8, minute: 00);
  DateTime notification_date = DateUtils.dateOnly(DateTime.now());
  var NotDate = '';
  var NotTime = '';

  String task = ''; /*  user task   */
  String description = ''; /*  user description   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*
      appBar: AppBar(
        title: const Text('Add Task Page'),
      ),
      */
        backgroundColor: const Color(0xffE6F4F1),
        body: Column(
          children: [
            const SizedBox(height: 100),
            /*    TASK NAME AND DESCRIPTION INPUTS   */
            Container(
              width: MediaQuery.of(context).size.width,
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xff929AE7),
                border: Border.all(color: const Color(0xff929AE7)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Task name : ',
                    style: TextStyle(fontSize: 25),
                  ),
                  TextField(
                      controller: _TaskController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      )),
                  Text(
                    'Description : ',
                    style: TextStyle(fontSize: 25),
                  ),
                  TextField(
                      controller: _DescriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      )),
                ],
              ),
            ),

            /*    ROW WITH ICON BUTTONS     */

            Container(
              color: Color(0xffff929AE7),
              child: Row(
                children: [
                  ElevatedButton(
                    child: Text("Calendar"),
                    onPressed: openDatePicker,
                  ),
                  ElevatedButton(
                    child: Text("Clock"),
                    onPressed: openTimePicker,
                  ),
                  ElevatedButton(
                    child: Text("Repeat"),
                    onPressed: _SaveTask, /* needs to be changed */
                  ),
                  ElevatedButton(
                    child: Text("Notification"),
                    onPressed: openNotificationWindow,
                  ),
                ],
              ),
            ),

            /*   CONFIRM BUTTONS  */
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xff929AE7),
                border: Border.all(color: Color(0xff929AE7)),
              ),
              child: Row(
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff06661B), // Background color
                    ),
                    child: Text('Confirm'),
                    onPressed: _SaveTask,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffA32F7D), // Background color
                    ),
                    child: Text('Invite a friend'),
                    onPressed: _SaveTask,
                  ),
                ],
              ),
            ),

            /*    SAVED PARAMETERS WINDOW   */
            Container(
              color: Colors.green,
              child: Column(children: [
                Text("USER'S INPUTS"),
                Text("Task name :"),
                Text(task),
                Text("Task Decription :"),
                Text(description),
                Text("Due date"),
                Text(DueDate),
                Text("Due time"),
                Text(DueTime)
              ]),
            ),
          ],
        ));
  }

  void _SaveTask() {
    setState(() {
      task = _TaskController.text;
      description = _DescriptionController.text;
    });
  }

  void openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        due_date = value!;
        DueDate = "${due_date.day}-${due_date.month}-${due_date.year}";
      });
    });
  }

  void openTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        due_time = value!;
        DueTime = due_time.format(context).toString();
      });
    });
  }

  Future openNotificationWindow() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Add a notification"),
          content: Container(
            child: Column(children: [
              Row(
                children: [
                  ElevatedButton(
                      child: Text("Select day"),
                      onPressed: openNotificationDay),
                  ElevatedButton(
                      child: Text("Select time"),
                      onPressed: openNotificationTime),
                ],
              ),
              Row(children: [
                const Text('Your notification date and time : '),
                Text(NotDate),
                const Text(" "),
                Text(NotTime)
              ]),
            ]),
          ),
        ),
      );

  void openNotificationDay() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        notification_date = value!;
        NotDate =
            "${notification_date.day}-${notification_date.month}-${notification_date.year}";
        openNotificationWindow();
      });
    });
  }

  void openNotificationTime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        notification_time = value!;
        NotTime = notification_time.format(context).toString();
        openNotificationWindow();
      });
    });
  }
}
