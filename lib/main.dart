import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/blocs.dart';
import 'package:to_do_app/src/constants/theme/theme.dart';
import 'presentation/screens/screens.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()..add(Login())),
        BlocProvider(create: (_) => TasksBloc()..add(GetListTask()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do App',
        theme: darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
