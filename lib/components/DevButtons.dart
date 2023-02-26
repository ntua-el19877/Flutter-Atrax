import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'HiveInit.dart';

class DevButtons extends StatefulWidget {
  final Box mybox;
  final Box friendbox;
  const DevButtons({required this.mybox, required this.friendbox});

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
                    {"date": "2023-03-01", "time": "10:00 AM"},
                    {"date": "2023-03-03", "time": "3:30 PM"},
                    {"date": "2023-03-05", "time": "8:15 AM"},
                  ],
                  importance: 'High',
                  location: 'latitude' + '37.7749' + 'longitude' + '-122.4194',
                  recordingFilePath: 'assets/recordings/Scoobydoo.mp3',
                  photoFilePath: 'assets/icons/empty.png',
                  friendName: ['John', 'Jane'],
                  completed: 'false',
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
        ElevatedButton(
          onPressed: () {
            setState(() {
              var f1 = generateRandomString();
              var f2 = generateRandomString();
              Friend friend1 = Friend(
                is_active: 'false',
                last_name: 'Loukas',
                name: 'Angelos',
                friendID: f1,
              );
              Friend friend2 = Friend(
                is_active: 'false',
                last_name: 'Giannopoulos',
                name: 'Spyros',
                friendID: f2,
              );
              widget.friendbox.put(f1, friend1);
              widget.friendbox.put(f2, friend2);
            });
          },
          child: Text("fill friend database"),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.friendbox.clear();
            });
          },
          child: Text("clear friend database"),
        )
      ],
    ));
  }
}
