import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

const todoListKey = 'todo-list';

class TodoRepository {
  late SharedPreferences prefs;

  Future<List<Todo>> getTodoList() async {
    prefs = await SharedPreferences.getInstance();

    final String jsonString = prefs.getString(todoListKey) ?? '[]';
    final jsonDecode = json.decode(jsonString) as List;

    return jsonDecode.map((e) => Todo.fromJson(e)).toList();
  }

  void saveTodoList(List<Todo> todos) {
    final String jsonString = json.encode(todos);
    prefs.setString(todoListKey, jsonString);
  }
}
