import 'package:flutter/material.dart';
import 'package:todo_list_3/widgets/todo_tile.dart';

import '../controllers/todos_controller.dart';
import '../models/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final focus = FocusNode();
  final controller = TodoControllers();
  final textController = TextEditingController();

  void onDelete(Todo todo) {
    controller.deleteTodo(todo);
    setState(() {});
  }

  void onAddTodo(Todo todo, int index) {
    controller.addTodo(todo, index: index);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    controller.loadTodos().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(),
        body: _body(),
      );

  AppBar _appBar() => AppBar(
        title: const Text('Todos'),
        centerTitle: true,
      );

  Widget _body() => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: TextField(
                  focusNode: focus,
                  controller: textController,
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  final newTodo = Todo(title: textController.text);
                  controller.addTodo(newTodo);
                  textController.clear();
                  focus.unfocus();
                  setState(() {});
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 5,
                  ),
                  child: Text('Nova tarefa'),
                ),
              ),
            ]),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: controller.todos.length,
                itemBuilder: (_, index) => TodoTile(
                  onAdd: onAddTodo,
                  onDelete: onDelete,
                  controller: controller,
                  todo: controller.todos[index],
                ),
              ),
            ),
          ],
        ),
      );
}
