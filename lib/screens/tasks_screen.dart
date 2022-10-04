import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cubit/task_cubit.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().getTasks();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          Container(margin: const EdgeInsets.all(12), child: const Text('Tasks:')),
          Expanded(
            child: BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                if (state is TaskInitial) {
                  return const Center(child: Text('TaskInitial ... '));
                } else if (state is TaskLoading) {
                  return const Center(child: Text('TaskLoading ... '));
                } else if (state is TaskLoaded) {
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
