import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'HiveInit.dart';

class DevButtons extends StatefulWidget {
  final Box mybox;
  const DevButtons({required this.mybox});

  @override
  _DevButtonsState createState() => _DevButtonsState();
}

String generateRandomString() {
  const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  final random = Random.secure();
  return List.generate(9, (index) => chars[random.nextInt(chars.length)])
      .join();
}

class _DevButtonsState extends State<DevButtons> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Row(
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                // final _mytask = _mybox.get('mytask');
                if (widget.mybox.length != 0) {
                  print(widget.mybox
                      .getAt(0)
                      .name); // will print the name of the task
                } else {
                  print('No task found!');
                }
              });
            },
            child: Text("read task")),
        ElevatedButton(
            onPressed: () {
              setState(() {
                int _len = widget.mybox.length;
                Task task = Task(
                  name: 'My Task$_len',
                  description: 'This is my task',
                  date: '2023-02-22',
                  time: '10:00 AM',
                  repetitiveness: 'Daily',
                  notifications: [
                    {
                      'time': '9:30 AM',
                      'message': 'Reminder: My Task at 10:00 AM'
                    }
                  ],
                  importance: 'High',
                  location: 'latitude' + '37.7749' + 'longitude' + '-122.4194',
                  recordingFilePath: '/path/to/recording',
                  photoFilePath: '/path/to/photo',
                  friendName: ['John', 'Jane'],
                );

                // final _mytask = _mybox.get('mytask');
                widget.mybox.put(generateRandomString(), task);

                print('Number of items in my box $_len+1');

                // var tasks = widget.mybox.values
                //     .where((task) => task.name == 'My Task1')
                //     .toList();
              });
            },
            child: Text("add task")),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (widget.mybox.length > 0) widget.mybox.deleteAt(0);
            });
          },
          child: Text("clear database"),
        ),
      ],
    ));
  }
}
