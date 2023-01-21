import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        children: const [
          CustomTextField(
            label: "Title",
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            label: "Category",
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(label: "When?"),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: null, child: Text("Add"))
        ],
      ),
    );
  }
}
