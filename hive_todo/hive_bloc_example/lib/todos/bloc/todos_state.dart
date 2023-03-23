part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosInitial extends TodosState {}

class TodoLoadedState extends TodosState {
  List<TaskModel> tasks;
  String username;
  TodoLoadedState(this.tasks, this.username);
  @override
  List<Object> get props => [tasks, username];
}
