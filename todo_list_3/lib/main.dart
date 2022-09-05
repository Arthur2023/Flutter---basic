import 'package:flutter/material.dart';
import 'package:todo_list_3/pages/home.dart';

import 'core/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Todo list',
        home: const HomePage(),
        theme: AppTheme.themeData,
      );
}
