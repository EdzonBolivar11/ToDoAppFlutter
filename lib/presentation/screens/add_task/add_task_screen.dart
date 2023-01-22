import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    void handlePressGoBack() => Navigator.pop(context);

    void handlePressAdd() {}

    return Screen(
      child: Column(
        children: [
          TopBar(
            children: [
              GestureDetector(
                onTap: handlePressGoBack,
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_back,
                      color: Color(0xFF1294F2),
                    ),
                    Text(
                      "To go back",
                      style: TextStyle(color: Color(0xFF1294F2), fontSize: 18),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "New Task",
                    style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                        color: titleTextColor),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            label: "Title",
          ),
          SizedBox(
            height: 15,
          ),
          CustomTextField(
            label: "Category",
          ),
          SizedBox(
            height: 15,
          ),
          CustomTextField(label: "When?"),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: handlePressAdd, child: Text("Add")),
        ],
      ),
    );
  }
}
