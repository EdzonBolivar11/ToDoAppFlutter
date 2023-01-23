import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';

class AddTaskScreen extends StatefulWidget {
  final DateTime selectedDay;

  const AddTaskScreen({Key? key, required this.selectedDay}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  late TextEditingController _whenController = TextEditingController();
  late TextEditingController txt = TextEditingController();
  String _firstDate = "";

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay;
    _focusedDay = widget.selectedDay;
    _firstDate = DateFormat('DD/MM/yyyy').format(widget.selectedDay);
    _whenController = TextEditingController(text: _firstDate);
  }

  @override
  void dispose() {
    _whenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        children: [
          _buildTopBar(context),
          ..._buildBody(context),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return TopBar(
      children: [
        GestureDetector(
          onTap: () => handlePressgoBack(context),
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
    );
  }

  void handlePressgoBack(BuildContext context) => Navigator.pop(context);

  List<Widget> _buildBody(BuildContext context) {
    return <Widget>[
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
      CustomTextField(
        label: "When?",
        enabled: false,
        icon: Icon(Icons.calendar_month),
        onPressed: () => handlePressCalendar(context),
        controller: _whenController,
      ),
      SizedBox(
        height: 20,
      ),
      ElevatedButton(onPressed: handlePressAdd, child: Text("Add")),
    ];
  }

  void handlePressAdd() {}

  void handleSelectDay(selectedDay, focusedDay, stfSetState) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      stfSetState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _whenController.text = DateFormat('DD/MM/yyyy').format(selectedDay);
      Navigator.pop(context);
    }
  }

  Future<String?> handlePressCalendar(BuildContext parentContext) {
    return showDialog(
      barrierDismissible: true,
      context: parentContext,
      builder: (context) => StatefulBuilder(
          builder: (stfContext, stfSetState) => Dialog(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TableCalendar(
                        calendarStyle: CalendarStyle(
                          todayDecoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        focusedDay: _focusedDay,
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(Duration(days: 365)),
                        headerStyle: HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false,
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 30,
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        onDaySelected: ((selectedDay, focusedDay) =>
                            handleSelectDay(
                                selectedDay, focusedDay, stfSetState)),
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
