import 'package:floor_project/entity/task.dart';
import 'package:floor_project/entity/taskDao.dart';
import 'package:floor_project/screen/text_input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListPage extends StatelessWidget {
  final String title;
  final TaskDao dao;

  const ListPage({
    required Key key,
    required this.title,
    required this.dao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.pinkAccent
       
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 151, 187),
        child: Icon(Icons.add),
        onPressed: () =>
            displayDialog(context: context, dao: dao, update: false, task: null),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<Task>>(
              stream: dao.findAllTasksAsStream(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return Container();

                final tasks = snapshot.data;

                return ListView.builder(
                  itemCount: tasks?.length,
                  itemBuilder: (_, index) {
                    return ListCell(
                      task: tasks![index],
                      dao: dao, key: Key(tasks[index].id.toString()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

_formatDate(int at) {
  return DateFormat.yMd()
      .add_jm()
      .format(DateTime.fromMillisecondsSinceEpoch(at));
}


class ListCell extends StatelessWidget {
  const ListCell({
    required Key key,
    required this.task,
    required this.dao,
  }) : super(key: key);

  final Task task;
  final TaskDao dao;

  _onLongPressUpdate(BuildContext context, TaskDao dao, bool update, Task task) {
    displayDialog(context: context, dao: dao, update: update, task: task);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
      child: Card(
        surfaceTintColor: Color.fromARGB(0, 255, 151, 188),
        elevation: 2.0,
        child: ListTile(
            onLongPress: () => _onLongPressUpdate(context, dao, true, task),
            title: Text(
              task.name,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            subtitle: Text(
              'created at  ${_formatDate(task.createdTime)}',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
            trailing: IconButton(
              onPressed: () async {
                await dao.deleteTask(task);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('task  ${task.name} is removed')),
                );
              },
              icon: Icon(
                Icons.remove_circle,
                color: Colors.red,
              ),
            )),
      ),
    );
  }
}