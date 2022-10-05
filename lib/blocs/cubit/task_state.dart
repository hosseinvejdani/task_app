part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {
  const TaskInitial();
}

class TasksLoading extends TaskState {
  const TasksLoading();
}

class TasksLoaded extends TaskState {
  final List<Task> tasks;
  const TasksLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskLoaded extends TaskState {
  final Task task;
  const TaskLoaded(this.task);

  @override
  List<Object> get props => [task];
}

class TaskError extends TaskState {
  final String message;
  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}
