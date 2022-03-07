import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/models/task_model.dart';
import 'package:my_todo_app/views/home_screen.dart';
import 'package:my_todo_app/widgets/default_form_field.dart';
import 'package:provider/provider.dart';
import 'package:my_todo_app/services/database.dart';

class EditScreen extends StatefulWidget {
  static final routeName = '/edit-screen';

  EditScreen({this.time, this.date, this.title, this.id});

  final String? time, date, title;
  final int? id;

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    titleController.text = widget.title!;
    timeController.text = widget.time!;
    dateController.text = widget.date!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff935050),
          centerTitle: true,
          title: const Text("Edit Screen"),
        ),
        backgroundColor: Colors.grey[200],
        body: Consumer<DatabaseHelper>(builder: (context, dataBaseHelper, _) {
          return Center(
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: titleController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Task title must not be empty';
                        }
                        return null;
                      },
                      label: 'Task Title',
                      prefix: Icons.title,
                    ),
                    const SizedBox(height: 15),
                    defaultFormField(
                        controller: timeController,
                        type: TextInputType.datetime,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Task time must not be empty';
                          }
                          return null;
                        },
                        label: 'Task Time',
                        prefix: Icons.watch_later_outlined,
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            timeController.text =
                                value!.format(context).toString();
                          });
                        }),
                    const SizedBox(height: 15),
                    defaultFormField(
                        controller: dateController,
                        type: TextInputType.datetime,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Task date must not be empty';
                          }
                          return null;
                        },
                        label: 'Task Date',
                        prefix: Icons.calendar_today,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2022-05-03'),
                          ).then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        }),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        print(titleController.text);
                        print(dateController.text);
                        print(timeController.text);
                        dataBaseHelper.updateData(
                            task: Task(
                                title: titleController.text,
                                time: timeController.text,
                                date: dateController.text,
                                id: widget.id),
                            status: 'new');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: screenWidth * 0.9166,
                        height: screenHeight * .0615,
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            border: Border.all(
                              color: Colors.brown,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: const Center(
                            child: Text(
                          "SAVE EDITS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "AvenirNextLTPro",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
