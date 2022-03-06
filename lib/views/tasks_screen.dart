import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/services/database.dart';
import 'package:my_todo_app/widgets/build_task_item.dart';
import 'package:my_todo_app/widgets/default_form_field.dart';
import 'package:my_todo_app/widgets/my_divider.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Provider.of<DatabaseHelper>(context, listen: false).createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseHelper>(builder: (context, provider, _) {
      return tasksBuilder(
        tasks: provider.newTasks,
      );
    });
  }

  Widget tasksBuilder({
    required List<Map> tasks,
  }) =>
      ConditionalBuilder(
        condition: tasks.isNotEmpty,
        builder: (context) => ListView.separated(
          itemBuilder: (context, index) {
            return buildTaskItem(tasks[index], context);
          },
          separatorBuilder: (context, index) => myDivider(),
          itemCount: tasks.length,
        ),
        fallback: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.menu,
                size: 100.0,
                color: Colors.grey,
              ),
              Text(
                'No Tasks Yet, Please Add Some Tasks',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
}
