import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/bloc/blocs.dart';
import 'package:to_do_app/data/datas.dart';
import 'package:to_do_app/presentation/screens/screens.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  String _titleDate = "";

  var now = DateTime.now();
  var formatter = DateFormat.yMMMMd('en_US');

  @override
  void initState() {
    super.initState();
    _titleDate = formatter.format(_focusedDay);
  }

  void handleNavigate() => Navigator.push(
      context, MaterialPageRoute(builder: (context) => AddUptadeTaskScreen()));

  void handleSelectDay(
      selectedDay, focusedDay, closeDialog, BuildContext context) {
    setState(() {
      _focusedDay = focusedDay;
      _selectedDay = selectedDay;
      _titleDate = formatter.format(focusedDay);
    });

    context.read<TasksBloc>().add(FilterTasks(dateTime: focusedDay));

    closeDialog();
  }

  void handlePressCalendar(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (contextD) {
        return Dialog(
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
                  firstDay: DateTime.now().add(Duration(days: -365)),
                  lastDay: DateTime.now().add(Duration(days: 365)),
                  headerStyle: HeaderStyle(
                    titleTextFormatter: (date, locale) =>
                        DateFormat.yMMM(locale).format(date),
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
                  onDaySelected: ((selectedDay, focusedDay) => handleSelectDay(
                      selectedDay,
                      focusedDay,
                      () => Navigator.pop(contextD),
                      context)),
                  selectedDayPredicate: (day) => isSameDay(DateTime.now(), day),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      onPressedAction: handleNavigate,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (_, state) => BlocBuilder<TasksBloc, TasksState>(
            builder: (_, state) => _build(context, state)),
      ),
    );
  }

  Widget _buildTopBar() {
    double screenWidth = MediaQuery.of(context).size.width;

    return TopBar(
      children: [
        Row(children: [
          Expanded(
              child: GestureDetector(
            onTap: () => handlePressCalendar(context),
            child: Row(
              children: [
                Text(
                  _titleDate,
                  style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: titleTextColor),
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.blue,
                )
              ],
            ),
          )),
          Image(
            image: AssetImage('assets/usuario.png'),
            width: 40,
          ),
        ]),
        BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            if (state is TasksLoaded) {
              dynamic lists =
                  getCompletedIncompletedList((state).listTaskModel!);
              return CategoryText(
                  "${lists["incompleted"].length} incomplete, ${lists["completed"].length} completed");
            }
            return CategoryText("");
          },
        ),
      ],
    );
  }

  Widget _build(BuildContext context, TasksState state) {
    switch (state.runtimeType) {
      case TasksInitial:
      case TasksLoading:
        return _buildLoading();
      case TasksLoaded:
        return Column(
          children: [
            _buildTopBar(),
            ..._buildLists(context, (state as TasksLoaded).listTaskModel!),
          ],
        );
      case TasksError:
      default:
        return AlertDialog(
          title: const Text('An error has ocurred'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    (state as TasksError).message ?? "Please try again later."),
              ],
            ),
          ),
        );
    }
  }

  List<Widget> _buildLists(BuildContext context, ListTaskModel state) {
    dynamic lists = getCompletedIncompletedList(state);

    return <Widget>[
      Expanded(
        child: ListToDo(title: "Incompleted", listTasks: lists["incompleted"]),
      ),
      Expanded(
        child: ListToDo(title: "Completed", listTasks: lists["completed"]),
      )
    ];
  }

  dynamic getCompletedIncompletedList(ListTaskModel state) {
    List<TaskModel> incompleted = [];
    List<TaskModel> completed = [];

    if (state.documents != null) {
      incompleted = List.from(state.documents!);
      completed = List.from(state.documents!);

      incompleted
          .retainWhere((e) => !(e.fields?.isCompleted.booleanValue as bool));

      completed
          .retainWhere((e) => (e.fields?.isCompleted.booleanValue as bool));
    }

    return {"incompleted": incompleted, "completed": completed};
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
