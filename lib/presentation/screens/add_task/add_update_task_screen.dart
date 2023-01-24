import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/bloc/blocs.dart';
import 'package:to_do_app/data/datas.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';
import 'package:to_do_app/src/helpers/extensions/color.dart';

class AddUptadeTaskScreen extends StatefulWidget {
  final TaskModel? taskModel;
  final String? title;
  final String? submitButtonText;
  const AddUptadeTaskScreen(
      {Key? key,
      this.taskModel,
      this.title = "New Task",
      this.submitButtonText = "Add"})
      : super(key: key);

  @override
  State<AddUptadeTaskScreen> createState() => _AddUptadeTaskScreenState();
}

class _AddUptadeTaskScreenState extends State<AddUptadeTaskScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  late TextEditingController _whenController = TextEditingController();
  late TextEditingController _titleController = TextEditingController();
  final String _firstDate = DateFormat('DD/MM/yyyy').format(DateTime.now());
  final _formKey = GlobalKey<FormState>();
  TaskModel _taskModel = TaskModel.copyWith();
  dynamic errors = {};

  String dropdownvalue = 'Item 1';

  List<DropdownMenuItem> _dropdownCategories = [];
  late CategoryModel _selectedCategory;

  final CategoriesBloc _categoriesBloc = CategoriesBloc();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
        text: widget.taskModel != null
            ? widget.taskModel!.fields!.name!.stringValue
            : "");
    _whenController = TextEditingController(
        text: widget.taskModel != null
            ? DateFormat('DD/MM/yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(
                    int.parse(widget.taskModel!.fields!.date!.integerValue) *
                        1000))
            : _firstDate);
    _categoriesBloc.add(GetListCategories());
    errors = {"title": false, "category": false, "date": false};
    _taskModel.fields!.date!.integerValue =
        DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10);

    if (widget.taskModel != null) {
      _taskModel = widget.taskModel!;
    }
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
          builder: _build,
        ),
      ),
    );
  }

  Widget _build(BuildContext context, CategoriesState state) {
    switch (state.runtimeType) {
      case CategoriesInitial:
      case CategoriesLoading:
        return _buildLoading();
      case CategoriesLoaded:
        _dropdownCategories = buildDropdownTestItems(
            (state as CategoriesLoaded).listCategoriesModel);
        try {
          if (widget.taskModel != null) {
            _selectedCategory = state.listCategoriesModel.documents!.firstWhere(
                (e) => e.name!.contains(
                    widget.taskModel!.fields!.categoryId!.stringValue));

            onChangeDropdown(_selectedCategory);
          }
          // ignore: empty_catches
        } catch (e) {}

        return Column(children: [
          _buildTopBar(context),
          _buildBody(context),
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
              widget.title!,
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

  Widget _buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        SizedBox(
          height: 10,
        ),
        CustomTextField(
          label: "Title",
          hasError: errors["title"],
          errorText: "Required",
          onChanged: (value) => setState(() {
            _taskModel.fields!.name!.stringValue = value;
            errors["title"] = value.isEmpty;
          }),
          controller: _titleController,
        ),
        SizedBox(
          height: 15,
        ),
        CustomTextField(
          label: "Category",
          errorText: "Required",
          enabled: false,
          child: Container(child: _buildCategoryField()),
        ),
        SizedBox(
          height: 15,
        ),
        CustomTextField(
          label: "When?",
          errorText: "Required",
          enabled: false,
          icon: Icon(Icons.calendar_month),
          onPressed: () => handlePressCalendar(context),
          controller: _whenController,
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () => handlePressAdd(context),
            child: Text(widget.submitButtonText!)),
      ]),
    );
  }

  onChangeDropdown(CategoryModel selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
      _taskModel.fields!.categoryId!.stringValue = selectedCategory.id;
    });
    handleError("category", false);
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

  void handleSelectDay(selectedDay, focusedDay, stfSetState) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      stfSetState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _taskModel.fields!.date!.integerValue = (selectedDay as DateTime)
            .millisecondsSinceEpoch
            .toString()
            .substring(0, 10);
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

  Widget _buildCategoryField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1,
                        color: errors["category"]
                            ? Colors.red
                            : Color(0xFF747476)))),
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
              onChanged: ((value) => onChangeDropdown(value)),
              dropdownColor: Color(0xFF2C2B30),
            ),
          ),
        )
      ]),
      Container(
        padding: errors["category"]
            ? EdgeInsets.symmetric(vertical: 10, horizontal: 20)
            : null,
        child: errors["category"]
            ? Text(
                "Required",
                style: TextStyle(color: Colors.red, fontSize: 13),
              )
            : null,
      )
    ]);
  }

  void handlePressAdd(BuildContext context) {
    if (_taskModel.fields!.name!.stringValue.isEmpty) {
      handleError("title", true);
    }

    if (_taskModel.fields!.categoryId!.stringValue.isEmpty) {
      handleError("category", true);
    }

    if (_taskModel.fields!.date!.integerValue.isEmpty) {
      handleError("date", true);
    }

    if (errors.toString().contains("true")) return;

    if (widget.title == "Add") {
      context.read<TasksBloc>().add(PostTask(taskModel: _taskModel));
    } else {
      context.read<TasksBloc>().add(UpdateTask(taskModel: _taskModel));
    }

    Navigator.pop(context);
  }

  void handleError(String key, bool value) {
    setState(() {
      errors[key] = value;
    });
  }

  //Loading
  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
