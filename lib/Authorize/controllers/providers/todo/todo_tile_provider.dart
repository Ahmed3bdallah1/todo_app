import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/Authorize/db/db_helper.dart';
import 'package:todo/utilties/task_model.dart';

import '../../../../utilties/constants.dart';

part 'todo_tile_provider.g.dart';

@riverpod
class TodoState extends _$TodoState {
  @override
  List<TaskModel> build() {
    return [];
  }

  void refresh() async {
    final data = await DbHelper.getTodos();
    state = data.map((e) => TaskModel.fromJson(e)).toList();
  }

  void addItem(TaskModel taskModel) async {
    await DbHelper.createItem(taskModel);
    refresh();
  }

  void updateItem(int id, String title, String description, String date,
      String start, String end, int isCompleted) async {
    await DbHelper.update(
        id, title, description, date, start, end, isCompleted);
    refresh();
  }

  Future<void> deleteItem(int id) async {
    await DbHelper.delete(id);
    refresh();
  }

  void isCompletedx(int id, String title, String description, String date,
      String start, String end, int isCompleted) async {
    await DbHelper.update(
        id, title, description, date, start, end, 1);
    refresh();
  }

  String todaysDate(){
    DateTime todayTime=DateTime.now();
    return todayTime.toString().substring(0,10);
  }

  String nextDayDate(){
    DateTime nextDayTime=DateTime.now().add(const Duration(days: 1));
    return nextDayTime.toString().substring(0,10);
  }

  String twoDaysDate(){
    DateTime nextDayTime=DateTime.now().add(const Duration(days: 2));
    return nextDayTime.toString().substring(0,10);
  }

  String weeksDate(){
    DateTime weeksTime=DateTime.now().add(const Duration(days: 7));
    return weeksTime.toString().substring(0,10);

  }

  List<String> allDate(){
    DateTime allTime=DateTime.now();
    DateTime allAfter=allTime.add(const Duration(days: 9490));
    List<String> dates=[];
    for(int i=0;i<9490;i++){
      DateTime date=allAfter.add(Duration(days: i));
      dates.add(date.toString().substring(0,10));
    }
    return dates;
  }


  List<String> monthAgo(){
    DateTime dateTime=DateTime.now();
    DateTime monthAgo=dateTime.subtract(const Duration(days: 30));

    List<String> dates=[];
    for(int i=0;i<30;i++){
      DateTime date=monthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0,10));
    }
    return dates;
  }

  dynamic getDynamicColor(){
    Random random=Random();
    int randomIndex=random.nextInt(colors.length);
    return colors[randomIndex];
  }

  bool getIsCompleted(TaskModel taskModel){
    bool? isCompleted;
    if(taskModel.isCompleted==0){
      isCompleted=false;
    } else{
      isCompleted=true;
    }
    return isCompleted;
  }
}
