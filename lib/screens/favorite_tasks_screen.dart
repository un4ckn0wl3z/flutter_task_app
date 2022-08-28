import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/models/task.dart';
import '../widgets/tasks_list.dart';

class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({Key? key}) : super(key: key);
  static const id = 'favorite_tasks_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> tasksList = state.favoriteTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  'Favorite | ${tasksList.length} Tasks',
                ),
              ),
            ),
            TaskList(tasksList: tasksList),
          ],
        );
      },
    );
  }
}
