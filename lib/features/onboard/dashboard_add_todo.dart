import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/Authorize/controllers/notifications/notification_helper.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/utilties/task_model.dart';
import 'package:todo/widgets/reused/app_style.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

import '../../Authorize/controllers/providers/dates/dates_provider.dart';
import '../../Authorize/controllers/providers/todo/todo_tile_provider.dart';

class AddTodo extends ConsumerStatefulWidget {
  const AddTodo({super.key});

  @override
  ConsumerState<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends ConsumerState<AddTodo> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  late NotificationHelper notificationHelper;
  late NotificationHelper helperController;
  List<int> notifications = [];

  @override
  void initState() {
    notificationHelper = NotificationHelper(ref: ref);
    Future.delayed(Duration.zero, () {
      helperController = NotificationHelper(ref: ref);
    });
    notificationHelper.initializeNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var customDate = ref.watch(dateStateProvider);
    var startDate = ref.watch(startTimeStateProvider);
    var endDate = ref.watch(finishTimeStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(.4),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            //title of the todo
            TextField(
              maxLines: 1,
              maxLength: 20,
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'add a title',
                labelStyle: appStyle(15, Colors.white, FontWeight.normal),
                // filled: true,
                // fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),

            //desc of the todo
            TextField(
              maxLines: 2,
              maxLength: 60,
              controller: descController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'add a description',
                labelStyle: appStyle(15, Colors.white, FontWeight.normal),
                // filled: true,
                // fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            //date time
            GestureDetector(
              onTap: () {
                picker.DatePicker.showDatePicker(context,
                    showTitleActions: true, minTime: DateTime(2023, 1, 1),
                    // maxTime: DateTime(2030, 12, 30),
                    // theme: const picker.DatePickerTheme(
                    //     doneStyle:
                    //         TextStyle(color: Colors.green, fontSize: 16)),
                    onConfirm: (date) {
                  ref
                      .read(dateStateProvider.notifier)
                      .setState(date.toString());
                }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
              },
              child: Container(
                width: Constants.kWidth,
                height: Constants.kHeight * .08,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    customDate == ""
                        ? 'set a date'
                        : customDate.substring(0, 10),
                    style: appStyle(16, Colors.black, FontWeight.normal),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            //start time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      ref
                          .read(startTimeStateProvider.notifier)
                          .setState(date.toString());
                      notifications =
                          ref.read(startTimeStateProvider.notifier).dates(date);
                    }, locale: picker.LocaleType.en);
                  },
                  child: Container(
                    width: Constants.kWidth * .4,
                    height: Constants.kHeight * .08,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        startDate == ""
                            ? 'start time'
                            : startDate.substring(10, 16),
                        style: appStyle(16, Colors.black, FontWeight.normal),
                      ),
                    ),
                  ),
                ),

                //finish time
                GestureDetector(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      ref
                          .read(finishTimeStateProvider.notifier)
                          .setState(date.toString());
                    }, locale: picker.LocaleType.en);
                  },
                  child: Container(
                    width: Constants.kWidth * .4,
                    height: Constants.kHeight * .08,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        endDate == "" ? 'end time' : endDate.substring(10, 16),
                        style: appStyle(16, Colors.black, FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //confirm the todo
            GestureDetector(
              onTap: () {
                // print("pressed");
                if (titleController.text.isNotEmpty &&
                    descController.text.isNotEmpty &&
                    customDate.isNotEmpty &&
                    startDate.isNotEmpty &&
                    endDate.isNotEmpty) {
                  TaskModel taskModel = TaskModel(
                      title: titleController.text,
                      description: descController.text,
                      isCompleted: 0,
                      date: customDate.substring(0, 10),
                      startTime: startDate.substring(10, 16),
                      endTime: endDate.substring(10, 16),
                      reminder: 0,
                      repeat: "yes");
                  notificationHelper.scheduledNotifications(
                      notifications[0],
                      notifications[1],
                      notifications[2],
                      notifications[3],
                      taskModel);
                  ref.read(todoStateProvider.notifier).addItem(taskModel);
                  ref.read(dateStateProvider.notifier).setState("");
                  ref.read(finishTimeStateProvider.notifier).setState("");
                  ref.read(startTimeStateProvider.notifier).setState("");
                  Navigator.pop(context);
                } else {
                  showDialog(context: context, builder: (_){
                    return CupertinoAlertDialog(
                      title: const Text("failed to add the task"),
                      content: const Text(
                        "please be sure that you entered all todo's data",
                      ),
                      actions: [
                        CupertinoDialogAction(
                            isDestructiveAction: true,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('close')),
                      ],
                    );
                  });
                }
              },
              child: Container(
                width: Constants.kWidth,
                height: Constants.kHeight * .08,
                decoration: BoxDecoration(
                  color: Constants.kGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Confirm',
                    style: appStyle(16, Colors.black, FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
