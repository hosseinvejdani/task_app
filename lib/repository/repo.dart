import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_app/models/task.dart';

class AppRepository {
  final String _tasksBoxName = 'tasksBox';
  // --------------------------------------
  Future<void> addTask(Task task) async {
    Box box;
    try {
      box = Hive.box(_tasksBoxName);
    } catch (e) {
      box = await Hive.openBox(_tasksBoxName);
    }

    if (box.containsKey(task.id)) {
      throw Exception('the task was alredy exists in database');
    } else {
      box.put(task.id, task);
    }
  }

  Future<void> updateTask(String taskId, Task newTask) async {
    Box box;
    try {
      box = Hive.box(_tasksBoxName);
    } catch (e) {
      box = await Hive.openBox(_tasksBoxName);
    }

    if (box.containsKey(taskId)) {
      box.delete(taskId);
      box.put(taskId, newTask);
    } else {
      throw Exception('the task with taskID = $taskId NOT found!');
    }
  }

  Future<void> deleteTask(String taskId) async {
    Box box;
    try {
      box = Hive.box(_tasksBoxName);
    } catch (e) {
      box = await Hive.openBox(_tasksBoxName);
    }

    if (box.containsKey(taskId)) {
      box.delete(taskId);
    } else {
      throw Exception('the task with taskID = $taskId NOT found!');
    }
  }

  Future<Task?> getTask(String taskId) async {
    Box box;
    try {
      box = Hive.box(_tasksBoxName);
    } catch (e) {
      box = await Hive.openBox(_tasksBoxName);
    }

    if (box.containsKey(taskId)) {
      return box.get(taskId);
    } else {
      throw Exception('the task with taskID = $taskId NOT found!');
    }
  }

  Future<List<Task>> getTasks() async {
    Box box;
    try {
      box = Hive.box(_tasksBoxName);
    } catch (e) {
      box = await Hive.openBox(_tasksBoxName);
    }

    List<Task> tasks = <Task>[];

    if (box.isNotEmpty) {
      tasks.addAll(box.values.cast<Task>());
    }
    return tasks;
  }
}
