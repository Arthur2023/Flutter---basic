import 'package:todo_list_3/service/service.dart';

import '../models/todo.dart';

class TodoControllers {
  final service = Service();

  List<Todo> todos = [];

  Future<void> loadTodos() async {
    todos = await service.readData();
  }

  Future<void> updateData() async {
    service.saveFile(todos);
  }

  void addTodo(Todo todo, {int? index}) {
    index == null ? todos.add(todo) : todos.insert(index, todo);
    updateData();
  }

  void deleteTodo(Todo todo) {
    todos.remove(todo);
    updateData();
  }
}
