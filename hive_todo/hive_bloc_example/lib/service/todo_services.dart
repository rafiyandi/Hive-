import 'package:hive/hive.dart';
import 'package:hive_bloc_example/model/task_model.dart';

class TodoServices {
  late Box<TaskModel> _task;

  Future<void> init() async {
    Hive.registerAdapter(TaskModelAdapter());
    _task = await Hive.openBox("tasks");
    await _task.clear();
  }

  List<TaskModel> getTask(final String username) {
    final tasks = _task.values.where((element) => element.user == username);

    return tasks.toList();
  }

  void addTask(final String task, final String username) {
    final addTask = TaskModel(username, task, false);

    _task.add(addTask);
    addTask.save();
  }

  Future<void> removeTask(final String task, final String username) async {
    final taskRemove = _task.values.firstWhere(
        (element) => element.task == task && element.user == username);
    await taskRemove.delete();
  }

  Future<void> updateTask(final String task, final String username) async {
    final taskToEdit = _task.values.firstWhere(
        (element) => element.task == task && element.user == username);
    final index = taskToEdit.key;
    await _task.put(index, TaskModel(username, task, !taskToEdit.completed));
  }
}
