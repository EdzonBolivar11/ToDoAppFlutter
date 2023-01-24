import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/bloc/blocs.dart';
import 'package:to_do_app/data/datas.dart';
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
  String _firstDate = "";

  String dropdownvalue = 'Item 1';

  List<DropdownMenuItem> _dropdownCategories = [];
  var _selectedCategory;

  final CategoriesBloc _categoriesBloc = CategoriesBloc();

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay;
    _focusedDay = widget.selectedDay;
    _firstDate = DateFormat('DD/MM/yyyy').format(widget.selectedDay);
    _whenController = TextEditingController(text: _firstDate);
    _categoriesBloc.add(GetListCategories());
  }

  @override
  void dispose() {
    _whenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: BlocProvider<CategoriesBloc>(
        create: (context) => _categoriesBloc,
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (_, state) => _build(context, state),
        ),
      ),
    );
  }

  onChangeDropdown(selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }

  Widget _build(BuildContext context, CategoriesState state) {
    switch (state.runtimeType) {
      case CategoriesInitial:
      case CategoriesLoading:
        return _buildLoading();
      case CategoriesLoaded:
        _dropdownCategories = buildDropdownTestItems(
            (state as CategoriesLoaded).listCategoriesModel);

        return Column(children: [
          _buildTopBar(context),
          ..._buildBody(context),
        ]);
      case CategoriesError:
      default:
        return AlertDialog(
          title: const Text('An error has ocurred'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text((state as CategoriesError).message ??
                    "Please try again later."),
              ],
            ),
          ),
        );
    }
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
        child: Row(children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xFF747476)))),
              child: DropdownBelow(
                itemWidth: MediaQuery.of(context).size.width * .9,
                itemTextstyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                boxTextstyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                boxPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                boxHeight: 55,
                hint: Text(
                  'Category',
                  style: TextStyle(fontSize: 14, color: Color(0xFFABAAAC)),
                ),
                value: _selectedCategory,
                items: _dropdownCategories,
                onChanged: onChangeDropdown,
                dropdownColor: Color(0xFF2C2B30),
              ),
            ),
          )
        ]),
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

  List<DropdownMenuItem> buildDropdownTestItems(
      ListCategoriesModel listCategories) {
    List<DropdownMenuItem> items = [];
    for (var i in listCategories.documents!) {
      var hexColor = i.fields!.color?.stringValue;
      hexColor = hexColor?.replaceAll("#", "");

      Color color = Colors.transparent;

      try {
        color = HexColor.fromHex(hexColor!);
        // ignore: empty_catches
      } catch (e) {}

      items.add(
        DropdownMenuItem(
          value: i,
          child: Row(
            children: [
              Expanded(child: Text(i.fields!.name!.stringValue)),
              Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return items;
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

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
