import 'package:flutter/material.dart';
import 'package:to_do_app/data/models/list.dart';
import 'package:to_do_app/presentation/screens/add_task/add_task.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTaskScreen()));
  }

  @override
  Widget build(BuildContext context) {
    ListItems list = ListItems(
        incompleted: ListItems.todoIncompletedList(),
        completed: ListItems.todoCompletedList());

    return Screen(
      onPressedAction: () => navigateTo(context),
      child: Column(
        children: [
          TopBar(),
          ListToDo(
            title: "Incompleted",
            items: list.incompleted,
          ),
          ListToDo(
            title: "Completed",
            items: list.completed,
          )
        ],
      ),
    );
  }
}
