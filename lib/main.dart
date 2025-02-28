import 'package:floor_project/db/database.dart';
import 'package:floor_project/entity/taskDao.dart';
import 'package:floor_project/screen/list_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase
      .databaseBuilder('flutter_database.db')
      .build();
  final dao = database.taskdao;

  runApp(MyApp(dao));
}


class MyApp extends StatelessWidget {
  final TaskDao dao;

  const MyApp(this.dao, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
     theme: ThemeData(
          primaryColor: Colors.deepPurple,
          hintColor: Colors.orange,
          colorScheme: ColorScheme.fromSwatch().copyWith(error: Colors.redAccent[100])),
      home: ListPage(key: UniqueKey(), title: 'Lista de tareas:', dao: dao),
    );
  }
}