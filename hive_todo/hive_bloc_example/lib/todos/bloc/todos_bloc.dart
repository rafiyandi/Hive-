import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_bloc_example/model/task_model.dart';
import 'package:hive_bloc_example/service/todo_services.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoServices _todoService;
  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emit) async {
      final todos = _todoService.getTask(event.username);
      emit(TodoLoadedState(todos, event.username));
    });

    on<AddtodosEvent>((event, emit) {
      final currentState = state as TodoLoadedState;
      _todoService.addTask(event.todosText, currentState.username);
      add(LoadTodosEvent(currentState.username));
    });

    on<ToggleTodosEvent>((event, emit) async {
      final currentState = state as TodoLoadedState;
      await _todoService.updateTask(event.todoTask, currentState.username);
      add(LoadTodosEvent(currentState.username));
    });

    on<RemoveTodosEvent>((event, emit) async {
      final currentState = state as TodoLoadedState;
      await _todoService.removeTask(event.todosTask, currentState.username);
      add(LoadTodosEvent(currentState.username));
    });
    on<UpdateTodosEvent>((event, emit) async {
      final currentState = state as TodoLoadedState;
      await _todoService.updateTask(event.todosTask, currentState.username);
      add(LoadTodosEvent(currentState.username));
    });
  }
}
