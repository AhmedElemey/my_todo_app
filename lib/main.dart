import 'package:flutter/material.dart';
import 'package:my_todo_app/services/database.dart';
import 'package:my_todo_app/views/bottom_nav_bar.dart';
import 'package:my_todo_app/views/home_screen.dart';
import 'package:my_todo_app/views/tasks_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: DatabaseHelper()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
