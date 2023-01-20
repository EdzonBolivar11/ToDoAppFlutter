// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:to_do_app/data/models/item.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';

class ItemToDo extends StatelessWidget {
  final Item item;

  const ItemToDo({Key? key, required this.item}) : super(key: key);

  handleChange() {
    item.done = !item.done;
  }

  @override
  Widget build(BuildContext context) {
    return !item.done
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
                        item.title,
                        style: TextStyle(fontSize: 17, color: titleTextColor),
                      ),
                    ),
                    DescriptionText(
                      item.description,
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
                  onChange: handleChange,
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: DescriptionText(item.title))
            ],
          );
  }
}
