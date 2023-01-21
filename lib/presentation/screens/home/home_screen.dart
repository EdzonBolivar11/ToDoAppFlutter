import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/data/models/list.dart';
import 'package:to_do_app/presentation/screens/add_task/add_task_screen.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTaskScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('MMMM D, yyyy');

    double screenWidth = MediaQuery.of(context).size.width;

    ListItems list = ListItems(
        incompleted: ListItems.todoIncompletedList(),
        completed: ListItems.todoCompletedList());

    return Screen(
      onPressedAction: () => navigateTo(context),
      child: Column(
        children: [
          TopBar(
            children: [
              Row(children: [
                Expanded(
                    child: Text(
                  formatter.format(now),
                  style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      color: titleTextColor),
                )),
                Image(
                  image: AssetImage('assets/usuario.png'),
                  width: 40,
                ),
              ]),
              DescriptionText("5 incomplete, 5 completed"),
            ],
          ),
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
