// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/repository/repo.dart';

import '../../models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(const TaskInitial());

  Future<void> addTask(Task task) async {
    try {
      emit(const TasksLoading());
      final repo = AppRepository();
      await repo.addTask(task);
      List<Task> tasks = await repo.getTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(const TaskError('Error!!'));
    }
  }

  Future<void> updateTask(String taskId, Task newTask) async {
    try {
      emit(const TasksLoading());
      final repo = AppRepository();
      await repo.updateTask(taskId, newTask);
      List<Task> tasks = await repo.getTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(const TaskError('Error!!'));
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      emit(const TasksLoading());
      final repo = AppRepository();
      await repo.deleteTask(taskId);
      List<Task> tasks = await repo.getTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(const TaskError('Error!!'));
    }
  }

  Future<void> getTask(String taskId) async {
    try {
      emit(const TasksLoading());
      final repo = AppRepository();
      await repo.getTask(taskId);
      Task? task = await repo.getTask(taskId);
      emit(TaskLoaded(task!));
    } catch (e) {
      emit(const TaskError('Error!!'));
    }
  }

  Future<void> getTasks() async {
    try {
      emit(const TasksLoading());
      // get tasks from repo
      final repo = AppRepository();
      List<Task> tasks = await repo.getTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(const TaskError('Error!!'));
    }
  }
}
