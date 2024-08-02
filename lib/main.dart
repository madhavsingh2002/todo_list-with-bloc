import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/todo_bloc.dart';
import 'bloc/todo_event.dart';
import 'bloc/todo_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo Bloc',
      home: BlocProvider(
        create: (context) => TodoBloc(),
        child: TodoPage(),
      ),
    );
  }
}

class TodoPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Todo Bloc')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter a task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    final task = _controller.text;
                    if (task.isNotEmpty) {
                      context.read<TodoBloc>().add(AddTodo(task));
                      _controller.clear();
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.todos[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                               _editTodoDialog(context, index, state.todos[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              context.read<TodoBloc>().add(DeleteTodo(index));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editTodoDialog(BuildContext parentContext, int index, String currentTask) {
  final TextEditingController _editController =
      TextEditingController(text: currentTask);

  showDialog(
    context: parentContext,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Task'),
        content: TextField(
          controller: _editController,
          decoration: InputDecoration(
            labelText: 'Task',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final updatedTask = _editController.text;
              if (updatedTask.isNotEmpty) {
                // Use the parentContext to access the Bloc
                parentContext.read<TodoBloc>().add(EditTodo(index, updatedTask));
              }
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}


}
