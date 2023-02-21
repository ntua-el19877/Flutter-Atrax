import 'dart:io';
import 'dart:async';
import 'package:atrax/entities/AddTaskJSON.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';


class FileManager{
  static late FileManager _instance;

  FileManager._internal(){
    _instance = this;
  }

  //factory FileManager() => _instance ?? FileManager._internal();
 
  factory FileManager() => FileManager._internal();

  Future<String> get _directoryPath async{
    //Directory directory = await getExternalStorageDirectory();
    var directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  Future<File> get _jsonFile async {
    final path = await _directoryPath;
    return File('$path/tasks.json');
  }

  writeJsonFile(json) async{

    File file = await _jsonFile;
    await file.writeAsString(AddTaskData.parseJson(json));
  }
}