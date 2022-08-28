import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';

import '../models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: tasksList.length,
          itemBuilder: (context, index) {
            var task = tasksList[index];
            return ListTile(
              title: Text(task.title),
              trailing: Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    context.read<TaskBloc>().add(UpdateTask(task: task));
                  }),
              onLongPress: () {
                context.read<TaskBloc>().add(DeleteTask(task: task));
              },
            );
          }),
    );
  }
}
