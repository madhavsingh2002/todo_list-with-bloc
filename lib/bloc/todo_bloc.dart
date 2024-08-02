import 'package:bloc/bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState(todos: [])) {
    on<AddTodo>((event, emit) {
      final updatedTodos = List<String>.from(state.todos)..add(event.task);
      emit(state.copyWith(todos: updatedTodos));
    });

    on<EditTodo>((event, emit) {
      final updatedTodos = List<String>.from(state.todos);
      updatedTodos[event.index] = event.updatedTask;
      emit(state.copyWith(todos: updatedTodos));
    });

    on<DeleteTodo>((event, emit) {
      final updatedTodos = List<String>.from(state.todos)..removeAt(event.index);
      emit(state.copyWith(todos: updatedTodos));
    });
  }
}
