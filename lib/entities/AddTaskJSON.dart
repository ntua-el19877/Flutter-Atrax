// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTaskModel {
  final String task;
  final String description; 
  final String DueDate;
  final String DueTime;
  final List notifications;

  AddTaskModel(
    this.task,
    this.description,
    this.DueDate,
    this.DueTime,
    this.notifications
  );
  
  AddTaskModel copyWith({
    String? task,
    String? description,
    String? DueDate,
    String? DueTime,
    List? notifications,
  }) {
    return AddTaskModel(
      task ?? this.task,
      description ?? this.description,
      DueDate ?? this.DueDate,
      DueTime ?? this.DueTime,
      notifications ?? this.notifications,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task': task,
      'description': description,
      'DueDate': DueDate,
      'DueTime': DueTime,
      'notifications': notifications,
    };
  }

  factory AddTaskModel.fromMap(Map<String, dynamic> map) {
    return AddTaskModel(
      map['task'] as String,
      map['description'] as String,
      map['DueDate'] as String,
      map['DueTime'] as String,
      List.from((map['notifications'] as List),)
    );
  }

  String toJson() => json.encode(toMap());

  factory AddTaskModel.fromJson(String source) => AddTaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddTaskModel(task: $task, description: $description, DueDate: $DueDate, DueTime: $DueTime, notifications: $notifications)';
  }

  @override
  bool operator ==(covariant AddTaskModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.task == task &&
      other.description == description &&
      other.DueDate == DueDate &&
      other.DueTime == DueTime &&
      listEquals(other.notifications, notifications);
  }

  @override
  int get hashCode {
    return task.hashCode ^
      description.hashCode ^
      DueDate.hashCode ^
      DueTime.hashCode ^
      notifications.hashCode;
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

  static parseJson(jsonData) async{
    await saveJsonData(jsonData);
    final prefs = await SharedPreferences.getInstance();
    var temp = prefs.getString('addTaskData');
    debugPrint('$temp');
    return temp;
  }
}
//import 'dart:convert';

List<Task> taskFromJson(String str) => List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
    Task({
        required this.name,
        required this.description,
        required this.date,
        required this.time,
        required this.repetitiveness,
        required this.notifications,
        required this.importance,
        //required this.location,
        //required this.recordingFilePath,
        //required this.photoFilePath,
        //required this.friendName,
    });

    String name;
    String description;
    String date;
    String time;
    String repetitiveness;
    List<Notification> notifications;
    String importance;
    //Location location;
    //String recordingFilePath;
    //String photoFilePath;
    //List<String> friendName;

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        name: json["name"],
        description: json["description"],
        date: json["date"],
        time: json["time"],
        repetitiveness: json["repetitiveness"],
        notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
        importance: json["importance"],
        //location: Location.fromJson(json["location"]),
        //recordingFilePath: json["recording_file_path"],
        //photoFilePath: json["photo_file_path"],
        //friendName: List<String>.from(json["friend_name"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "date": date,
        "time": time,
        "repetitiveness": repetitiveness,
        "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
        "importance": importance,
        //"location": location.toJson(),
        //"recording_file_path": recordingFilePath,
        //"photo_file_path": photoFilePath,
        //"friend_name": List<dynamic>.from(friendName.map((x) => x)),
    };
}

class Location {
    Location({
        required this.latitude,
        required this.longitude,
    });

    double latitude;
    double longitude;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}

class Notification {
    Notification({
        required this.date,
        required this.time,
    });

    String date;
    String time;

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        date: json["date"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
    };
}
