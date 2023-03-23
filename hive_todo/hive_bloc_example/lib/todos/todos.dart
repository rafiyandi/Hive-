import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_bloc_example/service/todo_services.dart';

import 'bloc/todos_bloc.dart';

class TodosPage extends StatelessWidget {
  TodosPage({super.key, required this.username});
  String username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: BlocProvider(
        create: (context) =>
            TodosBloc(RepositoryProvider.of<TodoServices>(context))
              ..add(LoadTodosEvent(username)),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodoLoadedState) {
              return ListView(
                children: [
                  ...state.tasks.map((e) => ListTile(
                        title: Text(e.task),
                        trailing: Checkbox(
                          value: e.completed,
                          onChanged: (value) {
                            // context
                            //     .read<TodosBloc>()
                            //     .add(RemoveTodosEvent(e.task));

                            context
                                .read<TodosBloc>()
                                .add(ToggleTodosEvent(e.task));
                          },
                        ),
                      )),
                  ListTile(
                    title: const Text("Create new todo"),
                    trailing: const Icon(Icons.create),
                    onTap: () async {
                      final result = await showDialog<String>(
                          context: context,
                          builder: (context) =>
                              const Dialog(child: CreateNewTask()));

                      if (result != null) {
                        context.read<TodosBloc>().add(AddtodosEvent(result));
                      }
                    },
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({super.key});

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

TextEditingController _inputContoller = TextEditingController();

class _CreateNewTaskState extends State<CreateNewTask> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Do you want create new task ? "),
        const SizedBox(height: 20),
        TextField(
          controller: _inputContoller,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(_inputContoller.text);
            },
            child: const Text("Save"))
      ],
    );
  }
}
