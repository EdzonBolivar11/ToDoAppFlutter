import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:to_do_app/bloc/categories/categories_bloc.dart';
import 'package:to_do_app/data/models/categories/list_categories.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  String _title = "";
  bool hasErrorsTitle = false;
  final CategoriesBloc _categoriesBloc = CategoriesBloc();

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    super.initState();
    _categoriesBloc.add(GetListCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return Column(children: [_buildTopBar(context), _buildBody(context)]);
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
              "Add Category",
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

  Widget _buildBody(BuildContext contextC) {
    return BlocProvider<CategoriesBloc>(
      create: (context) => _categoriesBloc,
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (contextB, state) {
          return Column(children: [
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: "Title",
              hasError: hasErrorsTitle,
              errorText: "Required",
              onChanged: (value) => setState(() {
                hasErrorsTitle = value.isEmpty;
                _title = value;
              }),
            ),
            SizedBox(
              height: 15,
            ),
            Text("Pick a color"),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () => openPicker(),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: pickerColor),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => handlePressAdd(contextB), child: Text("Add")),
          ]);
        },
      ),
    );
  }

  Future openPicker() {
    return showDialog(
        context: context,
        builder: (context_) => AlertDialog(
              title: const Text("Pick a color"),
              content: SingleChildScrollView(
                  child: ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
              )),
              actions: [
                ElevatedButton(
                    onPressed: () => handlePickColor(context),
                    child: const Text("Submit"))
              ],
            ));
  }

  void handlePickColor(BuildContext context) {
    setState(() {
      currentColor = pickerColor;
    });

    Navigator.pop(context);
  }

  void handlePressAdd(BuildContext context) {
    if (_title.isEmpty) {
      setState(() {
        hasErrorsTitle = true;
      });

      return;
    }

    CategoryModel categoryModel = CategoryModel(
        fields: FieldsCategory(
            color: ColorCategory(stringValue: pickerColor.value.toString()),
            name: NameCategory(stringValue: _title)));

    context
        .read<CategoriesBloc>()
        .add(PostCategory(categoryModel: categoryModel));

    Navigator.pop(context);
  }

  void handlePressgoBack(BuildContext context) => Navigator.pop(context);
}
