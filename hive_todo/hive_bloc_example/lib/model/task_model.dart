import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String user;
  @HiveField(1)
  final String task;
  @HiveField(2)
  final bool completed;

  TaskModel(this.user, this.task, this.completed);
}
