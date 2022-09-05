import 'package:flutter/material.dart';
import 'package:todo_list_3/controllers/todos_controller.dart';

import '../models/todo.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({
    super.key,
    required this.todo,
    required this.onAdd,
    required this.onDelete,
    required this.controller,
  });

  final Todo todo;
  final Function(Todo) onDelete;
  final Function(Todo, int) onAdd;
  final TodoControllers controller;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Dismissible(
          key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
          background: Container(
            color: Colors.grey,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.delete_forever, color: Colors.white),
              ),
            ),
          ),
          onDismissed: (_) {
            final currentIndex = widget.controller.todos.indexOf(widget.todo);

            widget.onDelete(widget.todo);

            final snackBar = SnackBar(
              content: Text('Tarefa "${widget.todo.title}" excluída'),
              action: SnackBarAction(
                onPressed: () => widget.onAdd(widget.todo, currentIndex),
                label: 'Desfazer',
                textColor: Colors.orange,
              ),
            );

            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: CheckboxListTile(
            value: widget.todo.checked,
            onChanged: (value) {
              widget.controller.updateData();
              setState(() => widget.todo.checked = value ?? false);
            },
            activeColor: Colors.orange,
            checkColor: Colors.black,
            tileColor: Colors.grey[800],
            title: Text(
              widget.todo.title,
              style: const TextStyle(color: Colors.black),
            ),
            secondary: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(
                widget.todo.checked ? Icons.check : Icons.error,
                color: Colors.black,
              ),
            ),
          ),
        ),
      );
}
