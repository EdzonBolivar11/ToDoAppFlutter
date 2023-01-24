// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/tasks/tasks_bloc.dart';
import 'package:to_do_app/data/datas.dart';
import 'package:to_do_app/presentation/screens/screens.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';

class TaskToDo extends StatefulWidget {
  final TaskModel task;

  const TaskToDo({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskToDo> createState() => _TaskToDoState();
}

class _TaskToDoState extends State<TaskToDo> {
  late TaskModel _task;

  @override
  void initState() {
    super.initState();
    _task = widget.task;
  }

  handleChange(BuildContext context) {
    setState(() {
      _task.fields!.isCompleted.booleanValue =
          !_task.fields!.isCompleted.booleanValue;
    });
    context.read<TasksBloc>().add(UpdateTask(taskModel: _task));
  }

  handleTap(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddUptadeTaskScreen(
                  title: "Update Task",
                  submitButtonText: "Update",
                  taskModel: widget.task,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return !widget.task.fields!.isCompleted.booleanValue
        ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.topLeft,
              child: CustomCheckbox(
                onChange: () => handleChange(context),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => handleTap(context),
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.task.fields!.name!.stringValue,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 17, color: titleTextColor),
                        ),
                      ),
                      CategoryText(
                        widget.task.fields!.categoryId!.nameValue ??
                            "Category not founded",
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        fontSize: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: widget.task.fields!.categoryId!.color,
                shape: BoxShape.circle,
              ),
            ),
          ])
        : Row(
            children: [
              Align(
                child: CustomCheckbox(
                  isChecked: true,
                  onChange: () => handleChange(context),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => handleTap(context),
                  child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: CategoryText(
                        widget.task.fields!.name!.stringValue,
                      )),
                ),
              ),
              Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: widget.task.fields!.categoryId!.color,
                    shape: BoxShape.circle,
                  ))
            ],
          );
  }
}
