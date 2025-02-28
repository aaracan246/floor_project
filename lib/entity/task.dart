import 'package:floor/floor.dart';

@entity
class Task{
    @PrimaryKey(autoGenerate: true)
    final int? id;

    String name;
    final int createdTime;
    bool completed;

    Task(this.id, this.name, this.createdTime, this.completed);
}