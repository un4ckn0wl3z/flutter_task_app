import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      removedTasks: state.removedTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: true)),
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false)),
          };
    emit(TaskState(
        pendingTasks: pendingTasks,
        removedTasks: state.removedTasks,
        completedTasks: completedTasks,
        favoriteTasks: state.favoriteTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = (List.from(state.pendingTasks))..remove(task);
    List<Task> removedTasks = (List.from(state.removedTasks))..remove(task);

    emit(TaskState(
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      pendingTasks: pendingTasks,
      removedTasks: removedTasks,
    ));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = (List.from(state.pendingTasks))..remove(task);
    List<Task> completedTasks = (List.from(state.completedTasks))..remove(task);
    List<Task> favoriteTasks = (List.from(state.favoriteTasks))..remove(task);

    List<Task> removedTasks = (List.from(state.removedTasks))
      ..add(task.copyWith(isDeleted: true));

    emit(TaskState(
      pendingTasks: pendingTasks,
      removedTasks: removedTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
    ));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
