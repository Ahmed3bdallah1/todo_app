import 'dart:convert';

class TaskModel {
  int? id;
  String? title;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  int? isCompleted;
  int? reminder;
  String? repeat;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.isCompleted,
    this.reminder,
    this.repeat,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    date: json["date"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    isCompleted: json["isCompleted"],
    reminder: json["reminder"],
    repeat: json["repeat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "date": date,
    "startTime": startTime,
    "endTime": endTime,
    "isCompleted": isCompleted,
    "reminder": reminder,
    "repeat": repeat,
  };
}

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());