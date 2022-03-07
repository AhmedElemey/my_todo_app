import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app/models/task_model.dart';
import 'package:my_todo_app/views/done_screen.dart';
import 'package:my_todo_app/views/tasks_screen.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper extends ChangeNotifier {
  int currentIndex = 0;

  int get getCurrentIndex {
    print(currentIndex);
    return currentIndex;
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];

  List<Widget> screens = [
    TasksScreen(),
    DoneScreen(),
  ];

  List<String> screenName = [
    'Tasks Screen',
    'Done Screen',
  ];
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  bool get getIsBottomSheetShown {
    return isBottomSheetShown;
  }

  IconData get getFabIcon {
    return fabIcon;
  }

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    notifyListeners();
  }

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        // print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          // print('table created');
        }).catchError((error) {
          // print('Error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        // print('database opened');
      },
    ).then((value) {
      database = value;
      notifyListeners();
    });
  }

  insertToDatabase({
    String? title,
    String? time,
    String? date,
  }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        notifyListeners();
        getDataFromDatabase(database);
        // print('$value inserted successfully');
      }).catchError((error) {
        // print('Error when inserting new record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    notifyListeners();
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else {
          doneTasks.add(element);
        }
      });
      notifyListeners();
    });
  }

  void updateData({
    required String status,
    required Task task,
  }) async {
    database!.update("tasks", task.toMap(),
        where: 'id = ?', whereArgs: [task.id]).then((value) {
      getDataFromDatabase(database);
      notifyListeners();
    });
  }

  void updateStatus({
    required String status,
    required int id,
  }) {
    database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      print(value);
      getDataFromDatabase(database);
      notifyListeners();
      // print(status.toString());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      // emit(AppDeleteDatabaseState());
      notifyListeners();
    });
  }
}
