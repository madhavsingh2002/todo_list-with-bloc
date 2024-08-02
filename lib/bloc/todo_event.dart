import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  final String task;

  AddTodo(this.task);

  @override
  List<Object> get props => [task];
}

class EditTodo extends TodoEvent {
  final int index;
  final String updatedTask;

  EditTodo(this.index, this.updatedTask);

  @override
  List<Object> get props => [index, updatedTask];
}

class DeleteTodo extends TodoEvent {
  final int index;

  DeleteTodo(this.index);

  @override
  List<Object> get props => [index];
}
