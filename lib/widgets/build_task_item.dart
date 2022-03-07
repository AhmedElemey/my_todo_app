import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/models/task_model.dart';
import 'package:my_todo_app/services/database.dart';
import 'package:my_todo_app/widgets/default_form_field.dart';
import 'package:my_todo_app/widgets/edit_screen.dart';
import 'package:provider/provider.dart';

var titleController = TextEditingController();
var timeController = TextEditingController();
var dateController = TextEditingController();

Widget buildTaskItem(Map model, context) =>
    Consumer<DatabaseHelper>(builder: (context, dataBaseHelper, _) {
      return Dismissible(
        key: Key(model['id'].toString()),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 5, left: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.black12,
                    offset: Offset(0.0, 0.6))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              shape: BoxShape.rectangle,
              // border: Border.all(
              //     color: Theme.of(context).colorScheme.primary)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.check_box,
                  ),
                  onPressed: () {
                    dataBaseHelper.updateStatus(
                      status: 'done',
                      id: model['id'],
                    );
                  },
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model['title']}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${model['date']}',
                            style: const TextStyle(
                                color: Color(0xff935050),
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            '${model['time']}',
                            style: const TextStyle(
                                color: Color(0xff935050),
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 50.0,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditScreen(
                          time: model['time'],
                          date: model['date'],
                          id: model['id'],
                          title: model['title'],
                        ),
                      ),
                    );
                  },
                  color: Colors.black45,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    dataBaseHelper.deleteData(id: model['id']);
                  },
                  color: Colors.black45,
                ),
              ],
            ),
          ),
        ),
        onDismissed: (direction) {
          dataBaseHelper.deleteData(id: model['id']);
        },
      );
    });
