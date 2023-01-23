import 'package:flutter/material.dart';
import 'package:to_do_app/data/datas.dart';
import 'package:to_do_app/presentation/widgets/list_to_do/task_to_do.dart';

class ListToDo extends StatelessWidget {
  final String title;
  final List<Document> listTasks;
  final String? emptyMessage;

  const ListToDo(
      {Key? key,
      this.title = "No title",
      this.listTasks = const [],
      this.emptyMessage = "No tasks founded."})
      : super(key: key);

  Widget _buildList() {
    if (listTasks.isEmpty) {
      return Align(alignment: Alignment.center, child: Text(emptyMessage!));
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
        itemCount: listTasks.length,
        itemBuilder: (context, i) {
          return TaskToDo(task: listTasks[i]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            )),
        Expanded(
          child: _buildList(),
        )
      ],
    );
  }
}
