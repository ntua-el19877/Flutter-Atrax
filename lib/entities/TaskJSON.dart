
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notification {
  String date;
  String time;

  Notification(this.date, this.time);

  Map toJson() => {
        'date': date,
        'time': time,
      };
}

class Task {
  String name;
  String description;
  String date;
  String time;
  List <dynamic> notifications;

  Task(
    this.name,
    this.description,
    this.date,
    this.time,
    this.notifications
    );

  Task.fromJson(Map<String, dynamic> json)
  : name = json['name'],
    description = json['description'],
    date = json['date'],
    time = json['time'],
    notifications = json['notifications'];
  
  Map toJson(){

    //List<Map> notifications= this.notifications.map((i)=>i.toJson()).toList(); 

    return{
    'name':name,
    'description':description,
    'date':date,
    'time':time,
    'notifications':notifications
    //'notifications':notifications.map((tag) => tag.toJson()).toList()
    };
  }
}

class AddTaskData{
  static saveJsonData(jsonData) async {
    final prefs = await SharedPreferences.getInstance();
    var saveData = jsonEncode(jsonData);
    await prefs.setString('addTaskData', saveData);
  }

  static getJsonData() async {
    final prefs = await SharedPreferences.getInstance();
    var temp = prefs.getString('addTaskData');
    debugPrint('Data received : $temp');
    var data = Task.fromJson(jsonDecode(temp.toString()));
    debugPrint('Task: ${(data.name.toString())}');
    debugPrint('Description: ${(data.description.toString())}');
    debugPrint('Due date: ${(data.date.toString())}');
    debugPrint('Due time: ${(data.time.toString())}');
    debugPrint('Notifications: ${(data.notifications.toString())}');
    
  }

}