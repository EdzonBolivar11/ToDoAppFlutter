import 'package:flutter/material.dart';
import 'package:to_do_app/src/constants/theme/theme.dart';
import 'presentation/screens/home/home_screen.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      theme: darkTheme,
      home: const HomeScreen(),
    );
  }
}
