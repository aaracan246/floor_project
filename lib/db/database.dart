import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floor_project/entity/task.dart';
import 'package:floor_project/entity/taskDao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart';

@Database(version: 1, entities: [Task])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskdao;
}