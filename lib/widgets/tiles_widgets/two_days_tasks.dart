import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/widgets/tiles_widgets/todo_tile.dart';
import '../../Authorize/controllers/providers/expansion_provider.dart';
import '../../Authorize/controllers/providers/todo/todo_tile_provider.dart';
import '../../features/onboard/dashboard_update_page.dart';
import '../../utilties/constants.dart';
import 'Expansion_tile.dart';

class TwoDaysTasks extends ConsumerWidget {
  const TwoDaysTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoStateProvider);
    String twoDays = ref.read(todoStateProvider.notifier).twoDaysDate();
    dynamic color2 = ref.read(todoStateProvider.notifier).getDynamicColor();
    var twoDaysTasks = todo.where((element) => element.date!.contains(twoDays));

    //the expansion tile that we return in home page
    return ExpansionTileEditied(
      firstText:
          "${DateTime.now().add(const Duration(days: 2)).toString().substring(5, 10)} tasks",
      secondText:
          'expand to check available tasks for \n${DateTime.now().add(const Duration(days: 2)).toString().substring(2, 10)}',
      onExpansionChanged: (expanded) {
        ref.read(expansion2Provider.notifier).setState(!expanded);
      },
      trailing: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: ref.watch(expansion2Provider)
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
        for (final tasks in twoDaysTasks)
          InkWell(
            onLongPress: () {
              Constants.titles = tasks.title!;
              Constants.descs = tasks.description!;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => UpdateTask(
                            id: tasks.id ?? 0,
                          )));
            },
            child: TodoTile(
              title: tasks.title,
              description: tasks.description,
              start: tasks.startTime,
              end: tasks.endTime,
              color: color2,
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
                                      .deleteItem(tasks.id ?? 0);
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
              editWidget: GestureDetector(
                onTap: () {
                  Constants.titles = tasks.title.toString();
                  Constants.descs = tasks.description.toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UpdateTask(
                                id: tasks.id ?? 0,
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
