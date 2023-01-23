// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:to_do_app/data/datas.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';

class TaskToDo extends StatelessWidget {
  final Document task;

  const TaskToDo({Key? key, required this.task}) : super(key: key);

  handleChange() {
    //task.done = !task.done;
  }

  @override
  Widget build(BuildContext context) {
    return task.fields!.isCompleted.booleanValue
        ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.topLeft,
              child: CustomCheckbox(
                onChange: handleChange,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        task.fields!.name!.stringValue,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17, color: titleTextColor),
                      ),
                    ),
                    CategoryText(
                      task.fields!.categoryId!.stringValue,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                      fontSize: 15,
                    ),
                  ],
                ),
              ),
            )
          ])
        : Row(
            children: [
              Align(
                child: CustomCheckbox(
                  isChecked: true,
                  onChange: handleChange,
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: CategoryText(
                      task.fields!.name!.stringValue,
                    )),
              )
            ],
          );
  }
}
