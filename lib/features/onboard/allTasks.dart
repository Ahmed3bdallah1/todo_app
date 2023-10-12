import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/widgets/tiles_widgets/todo_tile.dart';
import '../../Authorize/controllers/providers/todo/todo_tile_provider.dart';
import 'dashboard_update_page.dart';
import '../../utilties/constants.dart';
import '../../utilties/task_model.dart';

class AllTasks extends ConsumerStatefulWidget {
  const AllTasks({super.key});

  @override
  ConsumerState<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends ConsumerState<AllTasks> {
  @override
  Widget build(BuildContext context) {
    List<TaskModel> todosList = ref.watch(todoStateProvider);
    List allDates = ref.read(todoStateProvider.notifier).allDate();
    var allTasks = todosList
        .where((element) =>
            element.isCompleted == 0 ||
            allDates.contains(element.date!.substring(0, 10)))
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Tasks Available',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
          itemCount: allTasks.length,
          itemBuilder: (context, index) {
            final data = allTasks[index];
            // bool isCompleted =
            //     ref.read(todoStateProvider.notifier).getIsCompleted(data);
            dynamic color =
                ref.read(todoStateProvider.notifier).getDynamicColor();
            return InkWell(
              onLongPress: (){
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
                                  child: const Text('cancel')),
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
              ),
            );
          }),
    );
  }
}