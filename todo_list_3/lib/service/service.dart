import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/todo.dart';

class Service {
  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');
  }

  Future<void> saveFile(List<Todo> todos) async {
    List<Map<String, dynamic>> list = todos.map((e) => e.toJson()).toList();
    final jsonContent = json.encode(list);

    final file = await getFile();
    await file.writeAsString(jsonContent);
  }

  Future<List<Todo>> readData() async {
    try {
      final file = await getFile();
      final content = await file.readAsString();
      final jsonList = json.decode(content) as List;
      return jsonList.map((e) => Todo.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }
}
