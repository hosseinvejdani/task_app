import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/models/task.dart';

import '../blocs/cubit/task_cubit.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({super.key});

  final titleController = TextEditingController();

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          height: 200,
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text('Add Task :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: titleController,
                  autofocus: true,
                  decoration: const InputDecoration(label: Text('title'), border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        final task = Task(title: titleController.text);
                        context.read<TaskCubit>().addTask(task);
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(backgroundColor: Colors.green[400], foregroundColor: Colors.white),
                      child: const Text("Save"),
                    ),
                    const SizedBox(width: 20),
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().getTasks();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addTask(context),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(),
        body: Column(children: [
          Container(margin: const EdgeInsets.all(12), child: const Text('Tasks:')),
          Expanded(
            child: BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                if (state is TaskInitial) {
                  return const Center(child: Text('TaskInitial ... '));
                } else if (state is TasksLoading) {
                  return const Center(child: Text('TaskLoading ... '));
                } else if (state is TasksLoaded) {
                  return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: ((context, index) {
                        var task = state.tasks[index];
                        return ListTile(
                          title: Text(task.title),
                          trailing: Checkbox(
                            onChanged: (value) => {},
                            value: task.isDone,
                          ),
                        );
                      }));
                } else {
                  // state is TaskError
                  return const Center(child: Text('TaskError ... '));
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
