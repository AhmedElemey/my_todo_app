import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/services/database.dart';
import 'package:my_todo_app/widgets/default_form_field.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Provider.of<DatabaseHelper>(context, listen: false).createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DatabaseHelper>(context, listen: false);

    return Consumer<DatabaseHelper>(builder: (context, provider, _) {
      return Scaffold(
        key: scaffoldKey,
        body: provider.screens[provider.getCurrentIndex],
        appBar: AppBar(
          title: Text(
            '${provider.screenName[provider.getCurrentIndex]}',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (provider.getIsBottomSheetShown) {
              if (formKey.currentState!.validate()) {
                provider.insertToDatabase(
                  title: titleController.text,
                  time: timeController.text,
                  date: dateController.text,
                );
              }
            } else {
              scaffoldKey.currentState!
                  .showBottomSheet(
                    (context) => Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                                    print(timeController.text);
                                  });
                                }),
                            const SizedBox(height: 15),
                            Expanded(
                              child: defaultFormField(
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
                                      print(DateFormat.yMMMd().format(value!));
                                      dateController.text =
                                          DateFormat.yMMMd().format(value);
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 20.0,
                  )
                  .closed
                  .then((value) {
                provider.changeBottomSheetState(
                    isShow: false, icon: Icons.edit);
              });
              provider.changeBottomSheetState(isShow: true, icon: Icons.add);
            }
          },
          child: Icon(provider.getFabIcon),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.getCurrentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: 'Done',
            ),
            // // BottomNavigationBarItem(
            // //   icon: Icon(Icons.archive),
            // //   label: 'Archived',
            // ),
          ],
          onTap: (index) {
            print(index);
            provider.changeIndex(index);
            // setState(() {
            //
            // });
          },
        ),
      );
    });
  }
}
