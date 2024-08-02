import 'package:equatable/equatable.dart';

class TodoState extends Equatable {
  final List<String> todos;

  TodoState({required this.todos});

  TodoState copyWith({List<String>? todos}) {
    return TodoState(todos: todos ?? this.todos);
  }

  @override
  List<Object> get props => [todos];
}
