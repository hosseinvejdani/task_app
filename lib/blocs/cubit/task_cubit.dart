// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(const TaskInitial());

  Future<void> getTasks() async {
    try {
      emit(const TaskLoading());
      // get tasks from repo
      List<Task> tasks = _fakeRepo();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(const TaskError('Error!!'));
    }
  }

  Future<void> updateTask() async {}

  List<Task> _fakeRepo() {
    return [
      Task(title: 'task - 1'),
      Task(title: 'task - 2'),
      Task(title: 'task - 3'),
    ];
  }
}
