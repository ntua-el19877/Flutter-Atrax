import 'package:hive/hive.dart';
part 'HiveInit.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  String date;

  @HiveField(3)
  String time;

  @HiveField(4)
  String repetitiveness;

  @HiveField(5)
  List<Map<String, String>> notifications;

  @HiveField(6)
  String importance;

  @HiveField(7)
  String location;

  @HiveField(8)
  String recordingFilePath;

  @HiveField(9)
  String photoFilePath;

  @HiveField(10)
  List<String> friendName;

  Task({
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.repetitiveness,
    required this.notifications,
    required this.importance,
    required this.location,
    required this.recordingFilePath,
    required this.photoFilePath,
    required this.friendName,
  });
}

@HiveType(typeId: 1)
class Friend extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String last_name;

  @HiveField(2)
  bool is_active;

  Friend({
    required this.name,
    required this.last_name,
    required this.is_active
  });
}

// class TaskAdapter extends TypeAdapter<Task> {
//   @override
//   final typeId = 0;

//   @override
//   Task read(BinaryReader reader) {
//     int numOfFields = reader.readByte();
//     Map fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return Task(
//       name: fields[0],
//       description: fields[1],
//       date: fields[2],
//       time: fields[3],
//       repetitiveness: fields[4],
//       notifications: fields[5],
//       importance: fields[6],
//       location: fields[7],
//       recordingFilePath: fields[8],
//       photoFilePath: fields[9],
//       friendName: fields[10],
//     );
//   }

//   @override
//   void write(BinaryWriter writer, Task obj) {
//     writer
//       ..writeByte(11)
//       ..writeByte(0)
//       ..write(obj.name)
//       ..writeByte(1)
//       ..write(obj.description)
//       ..writeByte(2)
//       ..write(obj.date)
//       ..writeByte(3)
//       ..write(obj.time)
//       ..writeByte(4)
//       ..write(obj.repetitiveness)
//       ..writeByte(5)
//       ..write(obj.notifications)
//       ..writeByte(6)
//       ..write(obj.importance)
//       ..writeByte(7)
//       ..write(obj.location)
//       ..writeByte(8)
//       ..write(obj.recordingFilePath)
//       ..writeByte(9)
//       ..write(obj.photoFilePath)
//       ..writeByte(10)
//       ..write(obj.friendName);
//   }
// }
