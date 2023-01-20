import 'package:flutter/material.dart';
import 'package:to_do_app/data/models/list.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListItems list = ListItems(
        incompleted: ListItems.todoIncompletedList(),
        completed: ListItems.todoCompletedList());

    return Screen(
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
