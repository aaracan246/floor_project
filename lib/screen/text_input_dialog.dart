import 'package:floor_project/entity/task.dart';
import 'package:floor_project/entity/taskDao.dart';
import 'package:flutter/material.dart';

displayDialog(
    {required BuildContext context,
    required TaskDao dao,
    required bool update,
    required Task? task}) async {
  final TextEditingController textEditingController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            update ? 'Update task' : 'Add a task'
          ),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
                hintText: update ? task?.name : "enter a title"),
                
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(update ? 'UPDATE' : 'OK'),
              onPressed: () async {
                final message = textEditingController.text;
                if (update) {
                  task?.name = message;
                  await dao.updateTask(task!);
                } else {
                  final task = Task(
                      null, message, DateTime.now().millisecondsSinceEpoch, false);
                  await dao.insertTask(task);
                }
                textEditingController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}