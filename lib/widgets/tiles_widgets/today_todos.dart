import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/widgets/tiles_widgets/todo_tile.dart';

import '../../Authorize/controllers/providers/todo/todo_tile_provider.dart';
import '../../features/onboard/dashboard_update_page.dart';
import '../../utilties/task_model.dart';

class TodayTasks extends ConsumerWidget {
  const TodayTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> todosList = ref.watch(todoStateProvider);
    String todaytask = ref.read(todoStateProvider.notifier).todaysDate();
    var todaysList = todosList
        .where((element) =>
            element.isCompleted == 0 && element.date!.contains(todaytask))
        .toList();
    return ListView.builder(
        itemCount: todaysList.length,
        itemBuilder: (context, index) {
          final data = todaysList[index];
          bool isCompleted =
              ref.read(todoStateProvider.notifier).getIsCompleted(data);
          dynamic color =
              ref.read(todoStateProvider.notifier).getDynamicColor();
          return GestureDetector(
            onLongPress: () {
              Constants.titles = data.title.toString();
              Constants.descs = data.description.toString();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => UpdateTask(
                            id: data.id ?? 0,
                          )));
            },
            child: TodoTile(
              delete: () {
                print("deleted");
                showDialog(
                    context: context,
                    builder: (_) {
                      return CupertinoAlertDialog(
                          title: const Text("are u sure u want to delete"),
                          actions: [
                            CupertinoDialogAction(
                                onPressed: () {
                                  ref
                                      .read(todoStateProvider.notifier)
                                      .deleteItem(data.id ?? 0);
                                  Navigator.pop(context);
                                },
                                child: const Text('ok')),
                            CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('cancel'))
                          ]);
                    });
              },
              editWidget: GestureDetector(
                onTap: () {
                  Constants.titles = data.title.toString();
                  Constants.descs = data.description.toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UpdateTask(
                                id: data.id ?? 0,
                              )));
                },
                child: const Icon(Icons.edit_outlined, color: Colors.white),
              ),
              title: data.title,
              description: data.description,
              color: color,
              start: data.startTime,
              end: data.endTime,
              switcher: Switch(
                  inactiveThumbColor: Constants.kBlack.withOpacity(.6),
                  inactiveTrackColor: Colors.white,
                  focusColor: Colors.white,
                  value: isCompleted,
                  onChanged: (value) {
                    ref.read(todoStateProvider.notifier).isCompletedx(
                        data.id ?? 0,
                        data.title.toString(),
                        data.description.toString(),
                        data.date.toString(),
                        data.startTime.toString(),
                        data.endTime.toString(),
                        1);
                  }),
            ),
          );
        });
  }
}
