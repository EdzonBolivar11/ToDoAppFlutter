import 'package:flutter/material.dart';
import 'package:to_do_app/data/models/item.dart';
import 'package:to_do_app/presentation/widgets/list_to_do/item_to_do.dart';

class ListToDo extends StatelessWidget {
  final String title;
  final List<Item> items;

  const ListToDo({
    Key? key,
    this.title = "No title",
    this.items = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
            child: StreamBuilder(builder: (_, AsyncSnapshot snapshot) {
              return ListView.builder(
                physics: AlwaysScrollableScrollPhysics(
                    parent: ClampingScrollPhysics()),
                itemCount: items.length,
                itemBuilder: (context, i) {
                  return ItemToDo(item: items[i]);
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
