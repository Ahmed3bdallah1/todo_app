import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/widgets/tiles_widgets/todo_tile.dart';

import '../../Authorize/controllers/providers/expansion_provider.dart';
import '../../Authorize/controllers/providers/todo/todo_tile_provider.dart';
import '../../features/onboard/dashboard_update_page.dart';
import 'Expansion_tile.dart';

class TomorrowTasks extends ConsumerWidget {
  const TomorrowTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    String tomorrow = ref.read(todoStateProvider.notifier).nextDayDate();
    dynamic color = ref.read(todoStateProvider.notifier).getDynamicColor();
    var tomorrowTasks =
        todos.where((element) => element.date!.contains(tomorrow));

    return ExpansionTileEditied(
      firstText: "tomorrow's tasks",
      secondText:
          'expand to check available tasks for \n${DateTime.now().add(const Duration(days: 1)).toString().substring(2, 10)}',
      onExpansionChanged: (expanded) {
        ref.read(expansionProvider.notifier).setState(!expanded);
      },
      trailing: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: ref.watch(expansionProvider)
            ? const Icon(
                Icons.arrow_circle_down_outlined,
                color: Colors.white,
              )
            : const Icon(
                Icons.arrow_circle_up,
                color: Colors.white,
              ),
      ),
      children: [
        for (final todo in tomorrowTasks)
          InkWell(
            onLongPress: () {
              Constants.titles = todo.title!;
              Constants.descs = todo.description!;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => UpdateTask(
                            id: todo.id ?? 0,
                          )));
            },
            child: TodoTile(
              title: todo.title,
              description: todo.description,
              start: todo.startTime,
              end: todo.endTime,
              color: color,
              delete: () {
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
                                      .deleteItem(todo.id ?? 0);
                                  Navigator.pop(context);
                                },
                                child: const Text('ok')),
                            CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('cancel')),

                          ]);
                    });
              },
              editWidget: InkWell(
                onTap: () {
                  Constants.titles = todo.title.toString();
                  Constants.descs = todo.description.toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UpdateTask(
                                id: todo.id ?? 0,
                              )));
                },
                child: const Icon(Icons.edit_outlined, color: Colors.white),
              ),
              switcher: const SizedBox.shrink(),
            ),
          )
      ],
    );
  }
}
