part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class LoadTodosEvent extends TodosEvent {
  final String username;
  const LoadTodosEvent(this.username);
  @override
  List<Object> get props => [username];
}

class AddtodosEvent extends TodosEvent {
  final String todosText;
  const AddtodosEvent(this.todosText);
  @override
  // TODO: implement props
  List<Object> get props => [todosText];
}

class ToggleTodosEvent extends TodosEvent {
  final String todoTask;

  const ToggleTodosEvent(this.todoTask);
  @override
  // TODO: implement props
  List<Object> get props => [todoTask];
}

class RemoveTodosEvent extends TodosEvent {
  String todosTask;
  RemoveTodosEvent(this.todosTask);
  @override
  // TODO: implement props
  List<Object> get props => [todosTask];
}

class UpdateTodosEvent extends TodosEvent {
  String todosTask;
  UpdateTodosEvent(this.todosTask);
  @override
  List<Object> get props => [todosTask];
}
