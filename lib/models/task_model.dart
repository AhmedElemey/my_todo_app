/// TaskModel.dart
import 'dart:convert';

Task taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Task.fromMap(jsonData);
}

String taskToJson(Task data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Task {
  int? id;
  String? title;
  String? time;
  String? date;

  Task({
    this.id,
    this.title,
    this.time,
    this.date,
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        time: json["time"],
        date: json["date"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "time": time,
        "date": date,
      };
}
