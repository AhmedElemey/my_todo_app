import 'package:flutter/material.dart';
import 'package:my_todo_app/services/database.dart';
import 'package:provider/provider.dart';

Widget buildTaskItem(Map model, context) =>
    Consumer<DatabaseHelper>(builder: (context, dataBaseHelper, _) {
      return Dismissible(
        key: Key(model['id'].toString()),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                child: Text(
                  '${model['time']}',
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${model['title']}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${model['date']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              IconButton(
                icon: const Icon(Icons.check_box),
                onPressed: () {
                  dataBaseHelper.updateData(status: 'done', id: model['id']);
                  print("done?");
                },
                color: Colors.green,
              ),
              IconButton(
                icon: const Icon(Icons.delete,color: Colors.red,),
                onPressed: () {
                  dataBaseHelper.deleteData(id: model['id']);
                },
                color: Colors.black45,
              ),
            ],
          ),
        ),
        onDismissed: (direction) {
          dataBaseHelper.deleteData(id: model['id']);
        },
      );
    });
