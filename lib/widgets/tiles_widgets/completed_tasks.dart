import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/widgets/tiles_widgets/todo_tile.dart';

import '../../Authorize/controllers/providers/todo/todo_tile_provider.dart';
import '../../utilties/task_model.dart';

class CompletedTask extends ConsumerWidget {
  const CompletedTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> todosList = ref.watch(todoStateProvider);
    List lastMonth = ref.read(todoStateProvider.notifier).monthAgo();
    var completedTasks = todosList
        .where((element) =>
            element.isCompleted == 1 ||
            lastMonth.contains(element.date!.substring(0, 10)))
        .toList();
    return ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          final data = completedTasks[index];
          // bool isCompleted =
          //     ref.read(todoStateProvider.notifier).getIsCompleted(data);
          dynamic color =
              ref.read(todoStateProvider.notifier).getDynamicColor();
          return TodoTile(
            delete: () {
              print("deleted");
              showDialog(
                  context: context,
                  builder: (_) {
                    return CupertinoAlertDialog(
                        title: const Text("are u sure u want to delete"),
                        actions: [
                          FloatingActionButton(
                              onPressed: () {
                                ref
                                    .read(todoStateProvider.notifier)
                                    .deleteItem(data.id ?? 0);
                                Navigator.pop(context);
                              },
                              child: const Text('ok')),
                          FloatingActionButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('cancel')),
                        ]);
                  });
            },
            editWidget: const SizedBox.shrink(),
            title: data.title,
            description: data.description,
            color: color,
            start: data.startTime,
            end: data.endTime,
            switcher: data.isCompleted == 0
                ? const Icon(Icons.remove_circle, color: Constants.kRed)
                : const Icon(Icons.check_circle_rounded,
                    color: Constants.kGreen),
          );
        });
  }
}
